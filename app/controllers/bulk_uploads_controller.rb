class BulkUploadsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_section, only: %i[index new create]

  def index
    @bulk_uploads = current_user.bulk_uploads.all
  end

  def new
    @bulk_upload = current_user.bulk_uploads.new
  end

  def create
    @bulk_upload = current_user.bulk_uploads.new(bulk_upload_params)
    if @bulk_upload.save
      redirect_to bulk_upload_applicant_path, notice: 'File save successfully'
    else
      redirect_to bulk_upload_applicant_path, notice: 'File not saved'
    end
  end

  private

  def authorize_section
    authorize :BulkUpload
  end

  def bulk_upload_params
    params.permit(:id, :team_member_name, :team_member_id, :excel_doc).with_defaults(
      team_member_name: current_user.name, team_member_id: current_user.id
    )
  end
end
