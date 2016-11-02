class SubscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :authenticate_user!
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format.json? }
  before_action :plans, only: [:new]
  skip_before_filter :subscription
	def index
	end	

	def new
    
	end

  def plans
    @stripe_plan = Stripe::Plan.all
    @plans = @stripe_plan[:data]

    rescue Stripe::APIConnectionError => e
      flash[:error] = e.message
      redirect_to :back
  end  

	def create
    if current_user.stripe_customer_id.present?
      subscription = current_user.subscription
      customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
        if Stripe::Subscription.all(:customer => customer, :status => "canceled").present?
           canceled_sub = Stripe::Subscription.all(:customer => customer, :status => "canceled")
           canceled_sub.each do |c_subscription|
              if c_subscription[:id] == subscription.subscription_id
                stripe_subscription = customer.subscriptions.create(:plan => params[:plan_id])
                stripe_subscription.trial_end = "now"
                stripe_subscription.save            
                subscription.subscription_for_old_customer(stripe_subscription)
                flash[:notice] = "Thank you for joining CODEPAYER! You have now 1 month subscription."
                redirect_to new_dashboard_path and return
              end    
           end
        end  
    else   
      customer = Stripe::Customer.create(
        :email => current_user.email,
        :card  => params[:stripeToken],
        :description => "New customer"
      )
      subscription = customer.subscriptions.create(:plan => params[:plan_id])
      user = current_user.update_attributes(:stripe_customer_id => customer.id)
      Subscription.create_from_response(current_user, subscription)
      flash[:notice] = "Thank you for joining CODEPAYER! You now have a 30-day trial period before monthly charges will be added to your account."
      redirect_to new_dashboard_path
    end  

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to subscriptions_path
	end

  def cancel_subscription
    customer_id = current_user.stripe_customer_id
    subscription_id = current_user.subscription.subscription_id
    customer = Stripe::Customer.retrieve(customer_id)
    subscription = customer.subscriptions.retrieve(subscription_id)
    subscription.delete(:at_period_end => true)
    sub = current_user.subscription
    sub.continue = false
    sub.save
    redirect_to new_dashboard_path
  end

  def upgrade_trial_subscription
    customer_id = current_user.stripe_customer_id
    subscription = current_user.subscription
    stripe_customer = Stripe::Customer.retrieve(customer_id)
    stripe_subscription = stripe_customer.subscriptions.retrieve(subscription.subscription_id)
    stripe_subscription.plan = params[:plan_id] 
    stripe_subscription.save
    subscription.trial_subscription_upgrade(stripe_subscription)
    if params[:plan_id] == "devcode_pro_19"
      flash[:notice] = "Congratulations you have subscribed to DEVCODE PRO plan"
    elsif params[:plan_id] == "devcode_silver_49"
      flash[:notice] = "Congratulations you have subscribed to DEVCODE SILVER plan"
    else
      flash[:notice] = "Congratulations you have subscribed to DEVCODE GOLD plan"
    end 
    redirect_to new_dashboard_path 
  end

  def upgrade_active_subscription
    customer_id = current_user.stripe_customer_id
    subscription = current_user.subscription
    stripe_customer = Stripe::Customer.retrieve(customer_id)
    stripe_subscription = stripe_customer.subscriptions.retrieve(subscription.subscription_id)
    stripe_subscription.plan = params[:plan_id]
    stripe_subscription.trial_end = "now" 
    stripe_subscription.save
    subscription.active_subscription_upgrade(stripe_subscription)
    if params[:plan_id] == "devcode_pro_19"
      flash[:notice] = "Congratulations you have subscribed to DEVCODE PRO plan"
    elsif params[:plan_id] == "devcode_silver_49"
      flash[:notice] = "Congratulations you have subscribed to DEVCODE SILVER plan"
    else
      flash[:notice] = "Congratulations you have subscribed to DEVCODE GOLD plan"
    end 
    redirect_to new_dashboard_path
  end 

  def webhooks
    
    # puts "hello"
    data_json = JSON.parse request.body.read
    if params["data"]["object"]["customer"].present?
       customer_id = params["data"]["object"]["customer"]
       customer = Stripe::Customer.retrieve(customer_id)
       user = User.find_by_stripe_customer_id(customer_id)
      if user.present?
          event_type = params["type"]
          case event_type
          when "invoice.created"
            render :text => 'ok', :status => :ok
          when "charge.succeeded"
            render :text => 'ok', :status => :ok
          when "customer.updated"
            render :text => 'ok', :status => :ok
          when "invoice.payment_failed" 
            if params["data"]["object"]["subscription"].present?
              subscription_id = params["data"]["object"]["subscription"]
              subscripiton = user.subscription
              if user.subscription(subscription_id).present?
                stripe_subscription = customer.subscriptions.retrieve(subscription_id)
                stripe_subscription.delete
                subscripiton.subscription_invoice_failed(stripe_subscription)
                flash[:notice] = "Subscription Payment failed! Please Subscribe again"
                render :text => 'ok', :status => :ok
              end 
            else
              render :text => 'ok', :status => :ok
            end  

          when "invoice.payment_succeeded"
            if params["data"]["object"]["subscription"].present?
              subscription_id = params["data"]["object"]["subscription"]
              if user.subscription.subscription_id.present?
                 sub_response = customer.subscriptions.retrieve(subscription_id)
                 _subscription_update(user,sub_response)
                 render :text => 'ok', :status => :ok                     
              end
            else
              render :text => 'ok', :status => :ok
            end    
            # render :text => 'ok', :status => :ok

          when "customer.subscription.deleted"
            subscription_id = params["data"]["object"]["id"]
            if user.subscription.subscription_id == subscription_id
              subscription = user.subscription
              subscription.started_at = params["data"]["object"]["current_period_start"]
              subscription.ended_at = params["data"]["object"]["current_period_end"]
              subscription.status = params["data"]["object"]["status"]
              subscription.save
            end  
            render :text => 'ok', :status => :ok
         
          else
            render :text => 'ok', :status => :ok
          end
      end
    end
  end

  private

  def _subscription_update(user,response)
      sub = user.subscription
      sub.started_at =Time.at(response.current_period_start)
      sub.ended_at =Time.at(response.current_period_end)
      sub.status = response.status
      sub.save
  end

  def _invoice_payment_failed(user,subscription_id)
      sub = user.subscription(subscription_id)
      sub.status = "failed"
      sub.save
  end
end
