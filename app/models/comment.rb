class Comment < ActiveRecord::Base
  attr_accessible :message, :link_id

  belongs_to :user
  belongs_to :link
end