class EventPolicy < ActivityPolicy
  def book?
    @user && @record.bookable_now? 
  end
end


