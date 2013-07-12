class PagesController < ApplicationController
  def index
    params[:page] ||=1
    params[:per_page] ||=5

    @links = Link.page(params[:page].to_i).per_page(params[:per_page].to_i)
  end

end
