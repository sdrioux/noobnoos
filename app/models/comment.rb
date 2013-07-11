class Comment < ActiveRecord::Base
  acts_as_voteable
  
  attr_accessible :message, :link_id

  belongs_to :user
  belongs_to :link
end