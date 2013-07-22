class Link < ActiveRecord::Base
  include Simplificator::Webthumb

  acts_as_voteable

  attr_accessible :title, :url, :description, :thumbnail, :previewtext
  belongs_to :user
  has_many :comments

  #model callbacks - DO RESEARCH
  after_create :add_thumbnail

  after_create :add_preview_text

  def add_thumbnail
    et = Easythumb.new('f4915c6f9693f8e179f6307856253778','72561')
    self.thumbnail = et.build_url(:url => self.url, :size => :large, :cache => 1).to_s
    self.save
  end

  def add_preview_text
    if self.description.length < 200
      self.previewtext = self.description
      self.save
    else
      words = self.description.split(" ")
      preview = ""
      words.each do |word|
        preview +=" " + word if preview.length + word.size < 200
      end
      preview+="..."
      self.previewtext = preview
      self.save
    end
  end
end
