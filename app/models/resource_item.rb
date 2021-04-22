class ResourceItem < ApplicationRecord
  belongs_to :resource

  def to_s
    self.name
  end
end
