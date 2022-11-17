class Cluster < ApplicationRecord
  # SONO EDITIONS
  has_and_belongs_to_many :activities

  has_rich_text :details

  validates :name, uniqueness: true

  def to_s
    self.name
  end
end
