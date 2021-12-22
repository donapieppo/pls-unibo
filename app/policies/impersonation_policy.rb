class ImpersonationPolicy < ApplicationPolicy
  def who_impersonate?
    impersonate?
  end

  def impersonate?
    @user && @user.master_of_universe?
  end

  def stop_impersonating_user?
    @user && @user.master_of_universe?
  end
end
