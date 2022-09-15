FactoryBot.define do
  factory :audience do 
    sequence(:name) {|n| "audience_#{n}"}
  end
end

