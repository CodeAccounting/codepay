class ChargesController < ApplicationController

def index
	
end	

def new
	
end

def create
	# Amount in cents
    @amount = 2500
 
    # Create the customer in Stripe
    customer = Stripe::Customer.create(
      :email => 'sahil.codegaragetech@gmail.com',
      :card => params[:stripeToken]
    )
 
    # Create the charge using the customer data returned by Stripe API
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'usd'
    )
 
    # place more code upon successfully creating the charge
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path

 end 	
end
