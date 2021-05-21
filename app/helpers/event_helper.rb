module EventHelper
  private
  def is_event_owner?
    unless Event.find(params[:id]).admin == current_user
      flash[:alert] = "Vous ne pouvez pas modifier les événements créés par d'autres utilisateurs"
      redirect_back(fallback_location: root_path)
    end
  end
end
