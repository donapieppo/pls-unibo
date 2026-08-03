FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.test" }
    sequence(:name) { |n| "Name#{n}" }
    sequence(:surname) { |n| "Surname#{n}" }
    role { "other" }
    staff { false }

    trait :teacher do
      role { "teacher" }
      association :school
    end

    trait :student_secondary do
      role { "student_secondary" }
      association :school
    end

    trait :student_university do
      role { "student_university" }
    end

    trait :staff do
      staff { true }
    end
  end
end
