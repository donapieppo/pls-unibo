class Resource < ApplicationRecord
  has_and_belongs_to_many :activities
  has_and_belongs_to_many :resource_containers
  has_one_attached :document

  validates :name, presence: true, allow_blank: false

  def to_s
    self.name.blank? ? ' - ' : self.name
  end

  def video?
    self.url.blank? and return false
    self.url.match("^https://vimeo.com") || self.url.match("^https://(www.)?youtu\.?be")
  end

  def image?
    self.document.image?
  end

  def embed_url
    if url =~ /https:\/\/www\.youtube\.com\/watch\?v=([0-9a-zA-Z]+)/
      return "https://www.youtube.com/embed/#{$1}"

    elsif url =~ /https:\/\/youtu.be\/([0-9a-zA-Z]+)/
      return "https://www.youtube.com/embed/#{$1}"
    end
  end

  def document_type
    if self.image?
      return 'image'
    elsif self.video?
      return 'video'
    elsif ! self.url.blank?
      return 'url'
    else
      return 'document'
    end
  end
end
