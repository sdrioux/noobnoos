class CommentsController < ApplicationController
before_filter :authenticate_user!

  def create
    @comment = current_user.comments.create(params[:comment].merge(link_id: params[:link_id]))
    redirect_to :back
  end
end
