class School < ApplicationRecord
  has_many :users

  validates :code, uniqueness: true

  def to_s
    self.name
  end
end
