class EditionPolicy < ActivityPolicy
  def show?
    @record.visible? || @user&.staff?
  end

  def destroy?
    edit? && @record.events.empty?
  end

  def clone?
    edit?
  end
end
