class Contact < ApplicationRecord
  has_and_belongs_to_many :activities
  has_and_belongs_to_many :editions
  has_and_belongs_to_many :events
end
