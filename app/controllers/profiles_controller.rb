class ProfilesController < ApplicationController
  before_action :authenticate_team_member!
  before_action :load_resource, only: %w(show edit update destroy)
  before_action :authorize_section, only: %i[index show new create edit update destroy]

  def index
    @profiles = Profile.where(company_id: current_company.id)
	end

	def show
	end

	def new
		@profile = Profile.new
	end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to profiles_path, notice: "Profile created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: "Profile updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @profile.destroy
    redirect_to profiles_path, notice: "Profile is removed!"
  end

  private

  def authorize_section
    authorize :Profile
  end

  def profile_params
    params.require(:profile).permit(:id, :name, :company_id, :create_by, :description)
  end

  def load_resource
  	@profile = Profile.find params[:id]
  end

end