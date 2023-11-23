# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :current_user, :record

  def initialize(current_user, record)
    @current_user = current_user
    @record = record
  end

  def index?
    read?
  end

  def show?
    read?
  end

  def create?
    create?
  end

  def new?
    create?
  end

  def update?
    update?
  end

  def edit?
    update?
  end

  def destroy?
    delete?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end

  def read?
    return false unless current_user.permissions.find_by(model_title: model_title).present?

    current_user.permissions.find_by(model_title: model_title).send("read_p") && subscription_plan?
  end

  def create?
    return false unless current_user.permissions.find_by(model_title: model_title).present?

    current_user.permissions.find_by(model_title: model_title).send("create_p") && subscription_plan?
  end


  def update?
    return false unless current_user.permissions.find_by(model_title: model_title).present?

    current_user.permissions.find_by(model_title: model_title).send("update_p") && subscription_plan?
  end

  def delete?
    return false unless current_user.permissions.find_by(model_title: model_title).present?

    current_user.permissions.find_by(model_title: model_title).send("delete_p") && subscription_plan?
  end

  def subscription_plan?
    current_user.company.plans.map{|m| m.active_features}.flatten.include?(model_title.to_s)
  end
end
