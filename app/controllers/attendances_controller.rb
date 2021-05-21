class AttendancesController < ApplicationController
  before_action :authenticate_user!

  def new
    @attendance = Attendance.new
    @event = Event.find(params[:event_id])
  end

  def create

    @event = Event.find(params[:event_id])
    # Amount in cents
    @amount = @event.price * 100

    if @event.is_free?
      @attendance = Attendance.new(stripe_customer_id: nil, attendee: current_user, event: @event)
      if @attendance.save
        flash[:success] = "Vous êtes enregistré pour l'événement gratuit"
        redirect_to event_path(@event.id)
      else
        flash[:danger] = "Nous n'avons pas réussi à créer la nouvelle participation"
        redirect_to new_event_attendance_path(@event.id)
      end 
    else
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

      if customer && charge.paid
        @attendance = Attendance.new(stripe_customer_id: customer.id, attendee: current_user, event: @event)
        if @attendance.save
          flash[:success] = "Vous avez bien payé #{@event.price}"
          redirect_to event_path(@event.id)
        else
          flash[:danger] = "Nous n'avons pas réussi à créer la nouvelle participation"
          redirect_to new_event_attendance_path(@event.id)
        end 
      end
    end
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_event_attendance_path(@event.id)
  end

  def index
    @attendances = Attendance.where(event_id: params[:event_id])
    @event = Event.find(params[:event_id])
  end
end
