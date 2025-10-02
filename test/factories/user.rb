FactoryBot.define do
  factory :user do
    sequence(:upn) { |n| "upn#{n}" }
    add_attribute(:name) { "Pippo" }
    add_attribute(:surname) { "Pluto" }
  end
end
