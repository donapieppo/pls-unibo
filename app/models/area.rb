class Area < ApplicationRecord
  has_and_belongs_to_many :activities
  belongs_to :contact, foreign_key: "head_id"

  def to_s
    self.name
  end
end
