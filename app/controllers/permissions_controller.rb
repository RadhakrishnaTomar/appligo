# frozen_string_literal: true

class PermissionsController < ApplicationController
  before_action :authenticate_team_member!
  before_action :authorize_section, only: %i[index]

  def index
    @company = Company.find(params[:company_id])
    @companies_role = Role.joins(:team_members).where('team_members.id IN (?)',
                                                      @company.team_members.pluck(:id)).pluck(:name).sort.uniq.map do |item|
      [item, item]
    end
    @role = params[:role] || 'Admin'
    @models = Permission.all_models
  end

  def permissions_setter
    authorize :Permission
    @company = Company.find(params[:company_id])
    if @company.update(company_params)
      redirect_to company_permissions_path(@company, role: params[:company][:role]),
                  notice: 'Company permissions Updated'
    else
      redirect_to company_permissions_path(@company, role: params[:company][:role]),
                  alert: 'Company permissions Not Updated'
    end
  end

  private

  def authorize_section
    authorize :Permission
  end

  def company_params
    params.require(:company).permit(permissions_attributes: %i[id company_id role_id model_title read_p
                                                               create_p update_p delete_p])
  end
end
