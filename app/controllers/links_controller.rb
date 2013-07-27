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
      render :new
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to(@link)
    else
      render :edit
    end
  end

  def index
        params[:page] ||=1
    params[:per_page] ||=5
    # Only show the links that the current user has submitted, in order of upvote count.
    @links = Link.where(user_id: current_user.id).plusminus_tally.order('plusminus_tally ASC').page(params[:page].to_i).per_page(params[:per_page].to_i)
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

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to root_url
  end
end
