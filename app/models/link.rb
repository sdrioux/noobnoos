class Link < ActiveRecord::Base
  attr_accessible :title, :url, :description
  belongs_to :user
end
