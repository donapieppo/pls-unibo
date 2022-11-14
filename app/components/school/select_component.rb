# form fimplr_form
class School::SelectComponent < ViewComponent::Base
  def initialize(form)
    @f = form
    @provinces = School.distinct.pluck(:province).sort
  end
end
