class Profile < ActiveRecord::Base
  attr_accessible :facebook, :github, :twitter, :user_id
  belongs_to :user
end
