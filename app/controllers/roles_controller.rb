class RolesController < ApplicationController
  before_action :authenticate_team_member!
  before_action :load_resource, only: %w(show edit update destroy)
  before_action :authorize_section, only: %i[index show new create edit update destroy]

  def index
    @roles = Role.where(company_id: current_company.id)
	end

	def show
	end

	def new
		@profile = Role.new
	end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path, notice: "role created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @role.update(role_params)
      redirect_to role_path(@role), notice: "role updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @role.destroy
    redirect_to roles_path, notice: "role is removed!"
  end

  private

  def authorize_section
    authorize :Role
  end

  def role_params
    params.permit(:id, :name, :company_id, :create_by)
  end

  def load_resource
  	@role = Role.find params[:id]
  end

end