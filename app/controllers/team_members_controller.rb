class TeamMembersController < ApplicationController
  before_action :authenticate_team_member!
  before_action :get_team_member, only: [:show, :edit, :update, :destroy]
  before_action :authorize_section, only: %i[index show new create edit update destroy]


  def index
    search = params[:search]
    email = params[:email]
    name = params[:name]
    profile = params[:profile]
    employee_id = params[:employee_id]
    @company_members = current_team_member.company.team_members.search(search, email, name, profile, employee_id)
    @team_members = @company_members
  end

  def show
    if current_company.on_board?
      redirect_to edit_company_path(current_company.id)
    end
  end

  def new
    @team_member = TeamMember.new
    respond_to do |format|
      format.html
    end
  end

  def create
    # @team_member = TeamMember.new(team_member_params)
    # if @team_member.save
    #   redirect_to team_members_path, notice: "Employee registered"
    # else
    #   redirect_to new_team_member_path
    # end
  end


  def create_member
    @team_member = TeamMember.new(team_member_params)
    if @team_member.save
      redirect_to team_members_path, notice: "Employee registered"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @team_member.update(team_member_params)
      redirect_to team_members_path, notice: "Details Updated"
    else
      render :edit
    end
  end

  def destroy
    @team_member.destroy
    redirect_to team_members_path, notice: "Employee data removed!"
  end

  private

  def authorize_section
    authorize :TeamMember
  end

  def team_member_params
    params.require(:team_member).permit(:name, :employee_id, :email, :password, :contact_number, :role_id, :company_id, :profile, :search)
  end

  def get_team_member
    @team_member = TeamMember.find(params.fetch(:id))
  end
end
