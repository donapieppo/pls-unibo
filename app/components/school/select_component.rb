# form fimplr_form
class School::SelectComponent < ViewComponent::Base
  def initialize(form)
    @f = form
    @provinces = Hash.new { |hash, key| hash[key] = [] }

    School.order(:province, :name).all.each do |s|
      @provinces[s.province] << s
    end
  end
end
