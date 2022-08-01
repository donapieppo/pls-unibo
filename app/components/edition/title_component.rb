# frozen_string_literal: true

class Edition::TitleComponent < ViewComponent::Base
  def initialize(edition)
    @edition = edition
    @academic_year = @edition.academic_year_to_s
  end
end

