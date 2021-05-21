module UsersHelper
  private
  def is_profile_owner?
    unless current_user.id == params[:id].to_i
      flash[:alert] = "Vous ne pouvez pas accéder au profil d'autres utilisateurs"
      redirect_back(fallback_location: root_path)
    end
  end
end
