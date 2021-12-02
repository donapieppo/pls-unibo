class ProjectPolicy < ActivityPolicy
  def show?
    @record.visible? || (@user && @user.staff?)
  end

  def destroy?
    edit? && @record.editions.empty?
  end
end
