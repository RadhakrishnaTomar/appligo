class DesignationsController < ApplicationController
  before_action :get_designation, only: %i[show edit update destroy]
  before_action :authenticate_team_member!
  before_action :load_department!, only: %i[new create update]
  before_action :authorize_section, only: %i[index show new create edit update destroy]

  def index
    @designations = Designation.where(department_id: params[:department_id])
  end

  def show; end

  def new
    @designation = @department.designations.new
  end

  def create
    @designation = Designation.new(designation_params)
    if @designation.save
      redirect_to department_designations_path, notice: 'Designation created'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @designation.update(designation_params)
      redirect_to department_designations_path, notice: 'Designation Details Updated'
    else
      render :edit
    end
  end

  def destroy
    @designation.destroy
    redirect_to department_designations_path, notice: 'Designation removed!'
  end

  private

  def authorize_section
    authorize :Designation
  end

  def designation_params
    params.require(:designation).permit(:id, :name, :department_id).with_defaults(department_id: @department.id)
  end

  def get_designation
    @designation = Designation.find(params.fetch(:id))
  end

  def load_department!
    @department = Department.find(params[:department_id])
  end
end
