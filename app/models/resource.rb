class Resource < ApplicationRecord
  has_and_belongs_to_many :activities
  has_and_belongs_to_many :resource_containers
  has_one_attached :document

  before_validation :set_typology

  validates :name, presence: true, allow_blank: false

  def self.typologies
    ["document", "image", "video", "url"]
  end

  def to_s
    if self.display_name.blank?
      self.name.blank? ? " - " : self.name
    else
      self.display_name
    end
  end

  def video?
    if !self.url.blank?
      self.url.match("^https://vimeo.com") || self.url.match("^https://(www.)?youtu\.?be")
    end
  end

  def image?
    self.document.image?
  end

  def embed_url
    if url =~ /https:\/\/www\.youtube\.com\/watch\?v=([0-9a-zA-Z]+)/
      "https://www.youtube.com/embed/#{$1}"
    elsif url =~ /https:\/\/youtu.be\/([0-9a-zA-Z]+)/
      "https://www.youtube.com/embed/#{$1}"
    end
  end

  def video_thumbnail_url
    if url =~ /https:\/\/www\.youtube\.com\/watch\?v=([0-9a-zA-Z]+)/
      "https://i.ytimg.com/vi/#{$1}/hqdefault.jpg"
    elsif url =~ /https:\/\/youtu.be\/([0-9a-zA-Z]+)/
      "https://i.ytimg.com/vi/#{$1}/hqdefault.jpg"
    end
  end

  def document_type
    if self.image?
      "image"
    elsif self.video?
      "video"
    elsif !self.url.blank?
      "url"
    else
      "document"
    end
  end

  def name_and_type
    "#{self.name} (#{self.document.attachment.content_type})"
  end

  private

  def set_typology
    self.typology = self.document_type
  end
end
