class PagesController < ApplicationController
  def index
    @links = Link.order("created_at DESC")
  end

end
