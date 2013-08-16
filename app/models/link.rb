class Link < ActiveRecord::Base
  include Simplificator::Webthumb

  acts_as_voteable

  attr_accessible :title, :url, :description, :thumbnail, :previewtext, :tag_ids
  belongs_to :user
  has_many :comments
  has_many :favorites
  has_many :taggings
  has_many :tags, through: :taggings

  scope :by_score, joins("LEFT OUTER JOIN votes ON links.id = votes.voteable_id AND votes.voteable_type = 'Link'").
                   group('links.id').
                   order('SUM(CASE votes.vote WHEN true THEN 1 WHEN false THEN -1 ELSE 0 END) DESC')

  #add to sunspot search index
  searchable do
    text :title
  end

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

  # TAGGING CATEGORIES
  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) AS COUNT").joins(:taggings).group("taggings.tag_id")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end

  def tag_ids=(tag_ids)
    if self.persisted?
      self.taggings.destroy_all
      tag_ids.each do |tag_id|
        self.taggings.create(tag_id: tag_id) unless tag_id.blank?
      end
    else
      tag_ids.each do |tag_id|
        self.taggings.build(tag_id: tag_id)
      end
    end
  end
end
