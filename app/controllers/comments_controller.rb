class CommentsController < ApplicationController
before_filter :authenticate_user!

  def create
    @comment = current_user.comments.create(params[:comment].merge(link_id: params[:link_id]))
    format.js { render :layout => false}
    redirect_to :back
  end


  def vote_up
    begin
      current_user.vote_exclusively_for(@comment = Comment.find(params[:id]))
      redirect_to :back
    rescue ActiveRecord::RecordInvalid
      redirect_to :back
    end
  end

  def vote_down
    begin
      current_user.vote_exclusively_against(@comment = Comment.find(params[:id]))
      redirect_to :back
    rescue ActiveRecord::RecordInvalid
      redirect_to :back
    end
  end
end