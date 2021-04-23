class ResourceItem < ApplicationRecord
  belongs_to :resource

  def to_s
    self.name
  end

  def embed_url
    if url =~ /https:\/\/www\.youtube\.com\/watch\?v=([0-9a-zA-Z]+)/
      return "https://www.youtube.com/embed/#{$1}"

    elsif url =~ /https:\/\/youtu.be\/([0-9a-zA-Z]+)/
      return "https://www.youtube.com/embed/#{$1}"
    end
  end
end
