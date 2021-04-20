class Activity < ApplicationRecord
  before_destroy :check_children

  def check_children
    if Activity.where(parent_id: self.id).count > 0 
      throw :abort
    end
  end
end
