class Link < ActiveRecord::Base
  include Simplificator::Webthumb

  acts_as_voteable

  attr_accessible :title, :url, :description, :thumbnail
  belongs_to :user
  has_many :comments

  #model callbacks - DO RESEARCH
  after_create :add_thumbnail
  # ,  :if => :active_link?

  def add_thumbnail
    et = Easythumb.new('f4915c6f9693f8e179f6307856253778','72561')
    self.thumbnail = et.build_url(:url => self.url, :size => :large, :cache => 1).to_s
    self.save
  end

end
