class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :check_Admin
  helper_method :current_company
  before_action :registration_status_check, except: [:destroy]

  private

  def check_Admin
    @check_Admin ||= current_team_member.role.name == 'Admin' or current_team_member.role.name == 'HR'
  end

  def registration_status_check
    if devise_controller? && current_company&.on_board?
      redirect_to edit_company_path(current_company.id)
    end
  end



  protected

  def authorize_section
    authorize :Application
  end

  def current_company
    current_team_member&.company
  end

  def require_company!
    redirect_to root_path, alert: 'Unauthorized access!' unless current_company.present?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:name, :employee_id, :contact_number, :company_id, :role_id, :password,
                                             { company_attributes: %i[name location] }])
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :current_password, :employee_id, :contact_number, :company_id, :role_id)
    end
  end

  def current_user
    current_team_member
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end

  # def require_team!
  #   redirect_to root_path, alert: "Unauthorized access!" if current_team_member.role.name=="Admin".present?
  # end
end
