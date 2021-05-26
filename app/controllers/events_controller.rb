class EventsController < ApplicationController
  include EventHelper

  before_action :authenticate_user!, except: [:index, :show]
  before_action :is_event_owner?, only: [:update, :destroy, :edit]

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
      flash[:success] = 'Nouvel événement créé'
      redirect_to event_path(@event.id)
    else
      flash.now[:error] = "Nous n'avons pas réussi à créer l'événement' pour la (ou les) raison(s) suivante(s) :"
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    puts params
    if @event.update(title: params[:title], description: params[:description], start_date: params[:start_date], duration: params[:duration], price: params[:price], location: params[:location], admin: current_user)
      flash[:success] = 'Événement modifié'
      redirect_to event_path(@event.id)
    else
      flash.now[:error] = "Nous n'avons pas réussi à modifier l'événement' pour la (ou les) raison(s) suivante(s) :"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy unless @event.admin != current_user
    flash[:success] = 'Événement supprimé'
    redirect_to events_path
  end
end
