class LinksController < ApplicationController
  def show
    @link = Link.find(params[:id])
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(params[:link])
    @link.user = current_user

    if @link.save
      redirect_to @link
    else
      render action: 'new'
    end
  end
end
