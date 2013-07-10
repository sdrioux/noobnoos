class PagesController < ApplicationController
  def index
    params[:page] ||=1
    params[:per_page] ||=10

    @links = Link.order("created_at DESC").page(params[:page].to_i).per_page(params[:per_page].to_i)
  end

end
