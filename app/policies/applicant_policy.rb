class ApplicantPolicy < ApplicationPolicy
  attr_reader :current_user, :model_title

  def initialize(current_user, model_title)
    @current_user = current_user
    @model_title = model_title
  end

  def new_bulk_upload?
     create?
  end
end
