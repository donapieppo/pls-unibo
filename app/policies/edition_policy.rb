class EditionPolicy < ActivityPolicy
  def destroy?
    edit? && @record.events.empty?
  end
end
