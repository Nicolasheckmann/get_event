class EventsController < ApplicationController
  def index
    @events = Event.all
  end
  def new
    @event = Event.new
  end
  def show
    @event = Event.find(params[:id])
  end
  def create
    @event = Event.new(title: params[:event][:title], description: params[:event][:description], start_date: params[:event][:start_date], duration: params[:event][:duration], price: params[:event][:price], location: params[:event][:location], admin: current_user)
    if @event.save
      flash[:notice] = 'Nouvel événement créé'
      redirect_to event_path(@event.id)
    else
      flash.now[:notice] = "Nous n'avons pas réussi à créer l'événement' pour la (ou les) raison(s) suivante(s) :"
      render 'new'
    end
  end
end
