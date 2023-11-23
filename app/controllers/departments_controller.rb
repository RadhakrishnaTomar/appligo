class DepartmentsController < ApplicationController
  before_action :authenticate_team_member!
  before_action :require_company!
  before_action :load_resource!, only: %w(show edit update destroy)
  before_action :authorize_section, only: %i[index show new create edit update destroy]

	def index
    @departments = current_company.departments
	end

	def show
	end

	def new
		@department = current_company.departments.new
	end

  def create
    @department = current_company.departments.new(department_params)
    if @department.save
      redirect_to departments_path, notice: "Department created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @department.update(department_params)
      redirect_to department_path(@department), notice: "Department updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @department.destroy
    redirect_to departments_path, notice: "Department data removed!"
  end

  private

  def authorize_section
    authorize :Department
  end
  
  def department_params
    params.require(:department).permit(:id, :name)
  end

  def load_resource!
    @department = current_company.departments.find(params.fetch(:id))
  end
end

