# frozen_string_literal: true

class Activity::DetailsComponent < ViewComponent::Base
  def initialize(activity, no_link: false)
    @activity = activity
    @no_link = no_link
  end

  def icon_and_text(i)
    content_tag :div, class: "flex my-2" do
      (content_tag :div, class: "min-w-10" do
        tag.i class: i
      end) +
      (content_tag :div do
        yield
      end)
    end
  end
end
