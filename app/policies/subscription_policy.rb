class SubscriptionPolicy < ApplicationPolicy
  attr_reader :current_user, :model_title

  def initialize(current_user, model_title)
    @current_user = current_user
    @model_title = model_title
  end

  def subscription_plan?
    @current_user.company.plans.map{|m| m.active_features}.flatten.include?(@model_title)
  end
end
