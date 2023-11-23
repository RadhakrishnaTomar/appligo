# frozen_string_literal: true
class ApplicantsController < ApplicationController
  before_action :authenticate_team_member!
  before_action :get_applicant, only: %i[show edit update destroy]
  before_action :require_company!
  before_action :load_resource!, only: %w[ show edit update destroy]
  before_action :authorize_section, only: %i[index show new create edit update destroy]
  rescue_from Zip::Error, with: :invalid_attachment
  skip_before_action :verify_authenticity_token

  def index
    search = params[:search]
    email = params[:email]
    location = params[:location]
    contact_number = params[:contact_number]
    open_for = params[:open_for]
    @applicants = current_company.applicants.search(search, email, location, contact_number, open_for)
    @setting = current_company.organisation_setting || OrganisationSetting.new
    @profiles = Profile.all.pluck(:name)
  end

  def applicant_profile_data
    @profiles = current_company.profiles.pluck(:name)
    @setting = current_company.organisation_setting || OrganisationSetting.new  
    if params[:profile].present? && params[:profile] == "All"
      @applicants = current_company.applicants.all
    else
      profile_id = Profile.find(params[:profile])
      @applicants = current_company.applicants.where(profile_id: profile_id)
    end
  end

  def new
    @applicant = current_company.applicants.new
  end

  def create
    @applicant = current_company.applicants.new(applicant_params)
    profile = Profile.find_by(name:params[:applicant][:designation_name])
    @applicant.profile_id = profile.id if profile
    if @applicant.save
      redirect_to applicants_path, notice: 'Applicant created successfully!'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @applicant.update(applicant_params)
      redirect_to applicants_path, notice: 'Applicant updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @applicant.destroy
    redirect_to applicants_path, notice: 'Applicant destroy successfully!'
  end

  def new_bulk_upload
    @profiles = current_company.profiles
    authorize :Applicant
    @bulk_upload = current_user.bulk_uploads.new
  end

  def applicant_data_mapping
    file_data_fetch
    rejected_applicant
    if_applicant_rejected
  end

  def send_csv
    subs1 = params[:rejected_data].gsub 'AA', '@'
    subs2 = subs1.gsub '-', " \n "
    send_data(subs2, filename: "data-#{Date.today}.csv", disposition: :preview)
  end

  def generate_and_download
    package = Axlsx::Package.new
    workbook = package.workbook
    headers = [t(:name), t(:designation_name),t(:contact_number),t(:email),t(:current_location),t(:last_current_salary),t(:expected_salary),t(:notice_period),t(:open_for_wfh_wfo),t(:source)]

    workbook.add_worksheet(name: 'Sheet 1') do |sheet|
      sheet.add_row headers
    end

    respond_to do |format|
      format.xlsx do
        send_data package.to_stream.read, filename: 'headers_only.xlsx'
      end
    end
  end

  private

  def authorize_section
    authorize :Applicant
  end

  def applicant_params
    params.require(:applicant).permit(:name,:profile_id,:contact_number, :email, :location, :current_ctc,
                                      :expected_ctc, :notice_period, :open_for, :source,:remark,:hometown,:last_company,:experience,:relevant_expereince,:reason,:search, :company_id,:designation_name)
  end

  # private

  # def applicant_params_update
  #   params.require(:applicant).permit(:name,:designation_name,:contact_number,:email,:location,:current_ctc,
  #                                     :expected_ctc,:notice_period,:open_for,:source,:remark,:hometown,:last_company,:experience,:relevant_expereince,:reason,:profile_id )
  # end


  def get_applicant
    @applicant = Applicant.find(params.fetch(:id))
  end

  def load_resource!
    @applicant = current_company.applicants.find(params.fetch(:id))
  end

  def fetch_file_data
    @file_bulk = ActiveStorage::Blob.service.path_for(@bulk_upload.excel_doc.key)
    @xlsx = Roo::Spreadsheet.open(@file_bulk, extension: :xlsx)
    @column_name = @xlsx.row(1)
    @sheet = @xlsx.sheet('Worksheet')
  end

  def invalid_attachment
    flash[:alert] = 'Please attach xlsx file to upload Applicant'
    redirect_to bulk_upload_applicant_path
  end

  def make_record(row)
    values = @columns.map { |a| [a.to_sym, @hash_p[a].present? ? row[@hash_p[a]] : ""] }.to_h
    pattern = /wfh|home|home work|work home|work from home| Work from home/
    pattern1 = /wfo|office|office work|work office|o|work from office| Work from office|Office/

    if values[:open_for] =~ pattern
      values[:open_for] = "home"
    elsif values[:open_for] =~ pattern1
      values[:open_for] = "office"
    else
      values[:open_for] = "anywhere"
    end

    values.each do |key, value|
      values[key] = 'blank' if value.nil? || value.to_s.strip.empty?
    end

    values[:company_id] = "#{current_company.id}"
    values
  end


  def file_data_fetch
    @bulk_upload = current_user.bulk_uploads.create(bulk_upload_params)
    key = @bulk_upload.excel_doc.key # finds the key for the doc

    @file_bulk = ActiveStorage::Blob.service.path_for(key) # find the file path
    @xlsx = Roo::Spreadsheet.open(@file_bulk, extension: :xlsx) # opens the attachment
    @column_name = @xlsx.row(1).map(&:to_s).map(&:strip) # fetches the column name in excel file
    @sheet = @xlsx.sheet(0) # fetches the first sheet in excel file
    @hash_p = params[:mappings] # Fetches params Hash
    @hash_p.each do |k, v|
    @hash_p[k] = @column_name.find_index(v) # finds index of Excel calumn name
    end
    @columns = Applicant.column_names.dup - ["id", "created_at", "updated_at", "company_id","profile_id"]
  end

  def rejected_applicant
    @rejected_arr = []
    @data = [@column_name << 'status']
    profile_id = params[:profile_id]
    @sheet.parse.each do |row|
      a = Applicant.new(make_record(row))
      a.profile_id = profile_id
      if a.valid?
        a.save
      else
        @rejected_arr << row
      end
    end
  end

  def if_applicant_rejected
    if (@rejected_arr != []) || nil
      Tempfile.new(['rejected_data', '.csv']).tap do |_file|
        csv_calumn = @column_name
        csv_data = @rejected_arr
         
        @rejected_data = CSV.generate(headers: true) do |csv|
          csv << csv_calumn

          csv_data.each do |calumn|
            csv << calumn.map { |attr| attr }
          end
        end
      end
      nil
    else
      redirect_to bulk_upload_applicant_path, notice: 'data uploaded'
    end
  end
def bulk_upload_params
    params.permit(:id, :team_member_name, :team_member_id, :excel_doc).with_defaults(
      team_member_name: current_user.name, team_member_id: current_user.id
    )
  end
end
