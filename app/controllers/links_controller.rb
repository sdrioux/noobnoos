class LinksController < ApplicationController
  before_filter :authenticate_user!, only: [:vote_up, :vote_down, :create, :favorite]

  # ALL LINKS
  def index
    params[:page] ||=1
    params[:per_page] ||=5

    @search = Link.search do 
      fulltext params[:search]
    end
    @result = @search.results

    if params[:search]
      @links = @result
    else
      @links = Link.by_score.page(params[:page].to_i).per_page(params[:per_page].to_i)
    end
  end

  # SINGLE LINK
  def show
    @link = Link.find(params[:id])
    @comments = @link.comments.sort_by {|comment| comment.plusminus}.reverse
    @new_comment = @link.comments.build(params[:comment])
  end

  # NEW LINK
  def new
    @link = Link.new
  end

  # CREATE LINK 
  def create
    @link = Link.new(params[:link])
    @link.user = current_user

    if @link.save
      redirect_to @link
    else
      render :new
    end
  end

  # EDIT LINK
  def edit
    @link = Link.find(params[:id])
  end

  # UPDATE LINK
  def update
    @link = Link.find(params[:id])
    if @link.update_attributes(params[:link])
      redirect_to(@link)
    else
      render :edit
    end
  end

  # USERS LINKS
  def userlinks
    params[:page] ||=1
    params[:per_page] ||=5
    # Only show the links that the current user has submitted, in order of upvote count.
    @links = Link.where(user_id: current_user.id).plusminus_tally.order('plusminus_tally ASC').page(params[:page].to_i).per_page(params[:per_page].to_i)
    render action: 'index'
  end

  def taglinks
    params[:page] ||=1
    params[:per_page] ||=5

    @links = Tag.find_by_name(params[:id]).links.plusminus_tally.order('plusminus_tally ASC').page(params[:page].to_i).per_page(params[:per_page].to_i)
    render action: 'index'
  end

  # VOTE LINK UP
  def vote_up
    begin
      current_user.vote_exclusively_for(@link = Link.find(params[:id]))
      redirect_to :back
    rescue ActiveRecord::RecordInvalid
      redirect_to :back
    end
  end

  # VOTE LINK DOWN
  def vote_down
    begin
      current_user.vote_exclusively_against(@link = Link.find(params[:id]))
      redirect_to :back
    rescue ActiveRecord::RecordInvalid
      redirect_to :back
    end
  end

  # ADD OR REMOVE LINK FROM USER FAVORITES 
  def favorite
    if Favorite.where(user_id: current_user.id, link_id: params[:id]).exists?
      Favorite.where(user_id: current_user.id, link_id: params[:id]).destroy_all
    else
      Favorite.create(user_id: current_user.id, link_id: params[:id])
    end
    redirect_to :back
  end

  # INDEX OF USER'S FAVORITE LINKS
  def favorites
    params[:page] ||=1
    params[:per_page] ||=5
    @links = Link.where("Links.id IN (?) ", current_user.favorites).plusminus_tally.order('plusminus_tally ASC').page(params[:page].to_i).per_page(params[:per_page].to_i)
    render action: 'index'
  end
  
  # DESTROY LINK
  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to root_url
  end
end
