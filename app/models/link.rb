class Link < ActiveRecord::Base
  include Simplificator::Webthumb

  acts_as_voteable

  attr_accessible :title, :url, :description, :thumbnail, :previewtext
  belongs_to :user
  has_many :comments
  has_many :favorites

  scope :by_score, joins("LEFT OUTER JOIN votes ON links.id = votes.voteable_id AND votes.voteable_type = 'Link'").
                   group('links.id').
                   order('SUM(CASE votes.vote WHEN true THEN 1 WHEN false THEN -1 ELSE 0 END) DESC')

  #add to sunspot search index
  searchable do
    text :title
  end

  #model callbacks - DO RESEARCH
  after_create :add_thumbnail

  after_create :add_preview_text

  def add_thumbnail
    wt = Webthumb.new('099811cd90ed3133d359f06edd87db46')
    job = wt.thumbnail(:url => self.url)
    filename = File.join(Rails.root, 'tmp', self.title + '.jpg')
    job.write_file(job.fetch_when_complete(:large), filename)

    

    # Upload to S3
    file = Rails.application.config.storage_dir.files.create(
      #key is title.jpg of url
      :key    => filename.split('/').last,
      :body   => File.open(filename),
      :public => true
    )

    self.thumbnail = file.public_url

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
