class Event < ApplicationRecord
  include ContactRecordMap

  belongs_to :edition
end
