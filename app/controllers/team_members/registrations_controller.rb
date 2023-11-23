# frozen_string_literal: true

class TeamMembers::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication, only: [:new, :create]

  # POST /resource
  def create
    params[:team_member][:role_id] = Role.admin.first&.id
    super do |resource|
      unless resource.errors.empty?
        clean_up_passwords resource
        set_minimum_password_length
        render turbo_stream: turbo_stream.replace(
          "error_explanation",
          partial: "devise/shared/error_messages",
          locals: { resource: resource }
        )
        return
      end
    end
  end


  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
