class ActivityPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def choose_contact?
    true
  end

  def add_contact?
    true
  end
end
