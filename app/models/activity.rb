class Activity < ApplicationRecord
  has_and_belongs_to_many :resources
  has_many :bookings

  before_destroy :check_children

  validates :name, presence: true, allow_blank: false

  def check_children
    if Activity.where(parent_id: self.id).count > 0 
      throw :abort
    end
  end
end
