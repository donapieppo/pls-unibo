class Resource < ApplicationRecord
  has_and_belongs_to_many :activities
  has_one_attached :document

  validates :name, presence: true, allow_blank: false

  def to_s
    self.name.blank? ? ' - ' : self.name
  end

  def video?
    self.url or return false
    self.url.match("^https://vimeo.com") || self.url.match("^https://(www.)?youtu\.?be")
  end

  def image?
    false
  end

  def embed_url
    if url =~ /https:\/\/www\.youtube\.com\/watch\?v=([0-9a-zA-Z]+)/
      return "https://www.youtube.com/embed/#{$1}"

    elsif url =~ /https:\/\/youtu.be\/([0-9a-zA-Z]+)/
      return "https://www.youtube.com/embed/#{$1}"
    end
  end
end
