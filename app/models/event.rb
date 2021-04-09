class Event < ApplicationRecord
  belongs_to :edition
  has_and_belongs_to_many :contacts
end
