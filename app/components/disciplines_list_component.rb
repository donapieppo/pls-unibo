# frozen_string_literal: true

class DisciplinesListComponent < ViewComponent::Base
  def initialize(disciplines:)
    @disciplines = disciplines
  end
end
