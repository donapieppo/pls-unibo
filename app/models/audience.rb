class Audience < ApplicationRecord
  has_many :activities
  has_many :editions
end
