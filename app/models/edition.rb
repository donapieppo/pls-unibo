class Edition < ApplicationRecord
  include ContactRecordMap

  belongs_to :activity
  belongs_to :audience
  has_many :events

  validates :name, uniqueness: true, presence: true
  validates :academic_year, presence: true

  def to_s
    self.name
  end
end
