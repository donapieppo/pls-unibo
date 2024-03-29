class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    @user&.staff?
  end

  def new?
    create?
  end

  def update?
    @user&.staff?
  end

  def edit?
    update?
  end

  def destroy?
    @user&.staff?
  end

  def add_contact?
    @user&.staff?
  end

  def remove_contact?
    add_contact?
  end

  def add_resource?
    @user&.staff?
  end

  def choose_resource?
    add_resource?
  end

  def remove_resource?
    add_resource?
  end
end
