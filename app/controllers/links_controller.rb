class LinksController < ApplicationController
  def show
    @link = Link.find(params[:id])
    @comment = @link.comments.build
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

  def vote_up
    begin
      current_user.vote_exclusively_for(@link = Link.find(params[:id]))
      redirect_to :back
    rescue ActiveRecord::RecordInvalid
      redirect_to :back
    end
  end

  def vote_down
    begin
      current_user.vote_exclusively_against(@link = Link.find(params[:id]))
      redirect_to :back
    rescue ActiveRecord::RecordInvalid
      redirect_to :back
    end
  end
end
