class OrganisationSettingsController < ApplicationController

  def index
    @setting = current_company.organisation_setting || OrganisationSetting.new
  end

  def create_organisation
    @setting = OrganisationSetting.find_or_initialize_by(company_id: current_company.id)
    @setting.applicantseditableview = organisation_params[:applicantseditableview]
    if @setting.save
      redirect_to  applicants_path, notice: 'Applicant updated successfully!'
    end
  end


  private
  def organisation_params
    params.permit(:applicantseditableview)
  end

end

