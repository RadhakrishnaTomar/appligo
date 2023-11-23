# frozen_string_literal: true

module ApplicationHelper
  def company_permissions(company)
    arr = []
    role_id = current_team_member.role.id
    c_permissions = company.permissions

    @models.each do |model_title|
      permission = c_permissions.select { |s| s.model_title == model_title && s.role_id == role_id }.first
      arr << if permission.present?
               permission
             else
               Permission.new(model_title:, role_id:, company_id: company.id)
             end
    end
    arr
  end

  def role_dropdown
    role_id = Role.where(company_id: current_company.id).pluck(:name, :id)
  end

	def profile_dropdown(id)
    values = Profile.where(company_id: id).pluck(:name)
  end
end
