class UsersController < ApplicationController
  include UsersHelper

  before_action :authenticate_user!, only: [:show]
  before_action :is_profile_owner?, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    puts params
    if @user.update(description: params[:description], first_name: params[:first_name], last_name: params[:last_name] )
      flash[:notice] = 'Profil modifié'
      redirect_to user_path(@user.id)
    else
      flash.now[:notice] = "Nous n'avons pas réussi à modifier le profil pour la (ou les) raison(s) suivante(s) :"
      render :edit
    end
  end
end
