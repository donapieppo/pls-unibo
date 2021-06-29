class ContactPolicy < ApplicationPolicy
  def index?
    true
  end

  def delete_avatar?
    edit?
  end
end
