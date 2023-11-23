class CompaniesController < ApplicationController
  before_action :get_company, only: [:show, :edit, :update, :destroy]
  before_action :authorize_section, only: %i[index show new create edit update destroy]

  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @company = Company.new
    @company.team_members.build
  end

  def create
    @company = Company.new(company_params)
    @company.logo.attach(params[:company][:logo]) if params[:company][:logo].present?
    if @company.save
      redirect_to company_path(@company.id), notice: "Company created"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      if params[:company][:logo].present?
        @company.logo.attach(params[:company][:logo])
      end
      redirect_to company_path(@company), notice: "Company updated successfully!"
    else
      render :edit
    end
  end


  def destroy
    @company.destroy
    redirect_to root_path, notice: "Company data removed!"
  end

  private

  def authorize_section
    authorize :Company
  end

  def company_params
    params.require(:company).permit(:id, :name, :location, :website_url, :linkedin_url, :number_of_employees, :industry_type, :facebook_url, :logo, team_members_attributes: [:id, :name, :designation, :email, :password, :role_id], permissions_attributes: [:id, :company_id, :role_id, :model_title, :read_p, :write_p, :delete_p])
  end

  def get_company
    @company = Company.find(params[:id])
  end
end
