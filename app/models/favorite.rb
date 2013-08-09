class Favorite < ActiveRecord::Base
  attr_accessible :user_id, :link_id

  validates :link_id, :uniqueness => { :scope => :user_id }

  belongs_to :user
  belongs_to :link

end
