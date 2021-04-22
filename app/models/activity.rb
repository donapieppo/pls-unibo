class Activity < ApplicationRecord
  has_and_belongs_to_many :resources

  before_destroy :check_children

  def check_children
    if Activity.where(parent_id: self.id).count > 0 
      throw :abort
    end
  end
end
