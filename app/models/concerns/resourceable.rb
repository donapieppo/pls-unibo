# to be included in activity
module Resourceable
  extend ActiveSupport::Concern

  included do
    # has_one :bookability
    has_and_belongs_to_many :resources
  end
end
