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

  def self.school_types
    @@school_types ||= self.select(:school_type).distinct.pluck(:school_type).sort
  end

  def self.provinces
    @@provinces ||= self.select(:province).distinct.pluck(:province).sort
  end
end
