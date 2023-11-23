class SubscriptionsController < ApplicationController
  def index
    @subscriptions = current_company.plans #Subscription.includes(:plan)
    @plans = Plan.all
  end

  def show
    @subscription = Subscription.find(params[:id])
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.start_date = DateTime.now
    @subscription.end_date = DateTime.now + 1.year
    @subscription.subscribed_app = "Appligo"

    if @subscription.save
      redirect_to @subscription, notice: "Subscription created successfully."
    else
      render :new
    end
  end


  def edit
    @subscription = Subscription.find(params[:id])
  end

  def update
    @subscription = Subscription.find(params[:id])

    if @subscription.update(subscription_params)
      redirect_to @subscription, notice: "Subscription updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    @subscription.destroy

    redirect_to subscriptions_url, notice: "Subscription deleted successfully."
  end

  private

  def subscription_params
    params.require(:subscription).permit(:company_id, :subscribed_app, :start_date, :end_date, :plan_id)
  end
end
