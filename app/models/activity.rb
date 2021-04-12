class Activity < ApplicationRecord
  has_many :editions
  belongs_to :audience
  has_and_belongs_to_many :areas
  has_and_belongs_to_many :contacts

  validates :name, uniqueness: {}

  def to_s
    self.name
  end
end
