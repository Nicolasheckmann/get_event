class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :is_profile_owner?, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    puts params
    if @user.update(description: params[:user][:description], first_name: params[:user][:first_name], last_name: params[:user][:last_name] )
      flash[:notice] = 'Profil modifié'
      redirect_to user_path(@user.id)
    else
      flash.now[:notice] = "Nous n'avons pas réussi à modifier le profil pour la (ou les) raison(s) suivante(s) :"
      render :edit
    end
  end

  private
  def is_profile_owner?
    unless current_user.id == params[:id].to_i
      flash[:alert] = "Vous ne pouvez pas accéder au profil d'autres utilisateurs"
      redirect_back(fallback_location: root_path)
    end
  end
end
