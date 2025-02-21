class Campus < ApplicationRecord
  has_many :projects

  def to_s
    name
  end
end
