class Edition < ApplicationRecord
  belongs_to :activity
  belongs_to :audience
  has_many :events
  has_and_belongs_to_many :contacts

  validates :name, uniqueness: true, presence: true
  validates :academic_year, presence: true

  def to_s
    self.name
  end
end
