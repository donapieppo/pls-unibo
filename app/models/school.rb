class School < ApplicationRecord
  has_many :users
  has_many :bookings

  validates :code, uniqueness: true

  def to_s
    self.name
  end

  # FIXME database dirty
  def web_url
    case url
      # http//
    when /http\/\//
      url.gsub('http//', 'http://')
    when /https?:\/\//
      url
    when /www/
      "http://#{url}"
    end
  end
end
