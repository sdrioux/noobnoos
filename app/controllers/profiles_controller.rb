class ProfilesController < ApplicationController
  # before_filter :set_user

  # def set_user
  #   @user = current_user
  #   @profile = 3
  # end 

  def edit
  end

  def show
    @user = current_user
  end
  
end
