class Cluster < ApplicationRecord
  has_and_belongs_to_many :activities

  validates :name, uniqueness: true

  def to_s
    self.name
  end
end
