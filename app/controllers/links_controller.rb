class LinksController < ApplicationController
  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    @link.user = current_user || "none"

    if @link.save
      redirect_to @link
    else
      render action: 'new'
    end
  end

  def index
    @user_id = current_user.id
    @links = Link.where(user_id: @user_id)
  end
end
