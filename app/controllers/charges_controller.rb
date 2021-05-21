class ChargesController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end
  
  def create

    @event = Event.find(params[:event_id])
    # Amount in cents
    @amount = @event.price * 100
  
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
  
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @amount,
      description: 'Rails Stripe customer',
      currency: 'eur',
    })

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_charge_path(@event.id)
  end
end
