class EditionPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def choose_contact?
    add_contact?
  end

  def add_contact?
    true
  end

  def add_speaker?
    add_contact?
  end

  def remove_contact?
    add_contact?
  end

  def remove_speaker?
    add_contact?
  end
end
