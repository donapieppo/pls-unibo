class School < ApplicationRecord
  has_many :users
  has_many :bookings

  validates :code, uniqueness: true

  def to_s
    self.name
  end
end
