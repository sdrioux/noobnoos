class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :link
  
  attr_accessible :tag_id, :link_id
end
