class ResourceContainerPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def add_resource?
    true
  end

  def choose_resource?
    add_resource?
  end

  def remove_resource?
    add_resource?
  end
end
