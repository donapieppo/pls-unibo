class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def add_contact?
    true
  end

  def remove_contact?
    add_contact?
  end

  def choose_resource?
    add_contact?
  end

  def add_resource?
    add_contact?
  end

  def remove_resource?
    add_contact?
  end

  def destroy?
    true
  end
end


