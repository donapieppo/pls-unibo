class EditionPolicy < ActivityPolicy
  def book?
    @record.bookable 
  end
end
