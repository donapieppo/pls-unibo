class ProjectPolicy < ActivityPolicy
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
end
