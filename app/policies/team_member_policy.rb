class TeamMemberPolicy < ApplicationPolicy
  attr_reader :current_user, :model_title

  def initialize(current_user, model_title)
    @current_user = current_user
    @model_title = model_title
  end

  def create_member?
    write?
  end
end
