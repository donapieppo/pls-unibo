FactoryBot.define do
  factory :activity_type do 
    sequence(:name) {|n| "audience_#{n}"}
  end
end
