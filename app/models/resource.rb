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
    if display_name.blank?
      name.blank? ? " - " : name
    else
      display_name
    end
  end

  def video?
    if !url.blank?
      url.match("^https://vimeo.com") || url.match("^https://(www.)?youtu\.?be")
    end
  end

  def image?
    document.image?
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
    if image?
      "image"
    elsif video?
      "video"
    elsif url.blank?
      "url"
    else
      "document"
    end
  end

  def name_and_type
    "#{name} (#{document.attachment.content_type})"
  end

  private

  def set_typology
    typology = document_type
  end
end
