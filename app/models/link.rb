class Link < ActiveRecord::Base
  acts_as_voteable

  attr_accessible :title, :url, :description
  belongs_to :user
  has_many :comments
end
