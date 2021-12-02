class EditionPolicy < ActivityPolicy
  def show?
    @record.visible? || (@user && @user.staff?)
  end

  def destroy?
    edit? && @record.events.empty?
  end
end
