class ProjectPolicy < ActivityPolicy
  def destroy?
    edit? && @record.editions.empty?
  end
end
