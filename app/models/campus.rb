class Campus < ApplicationRecord
  has_many :projects

  def to_s
    self.name
  end
end

