FactoryBot.define do
  factory :user do 
    sequence(:email) {|n| "upn#{n}@example.com"}
    name    { "Pippo" }
    surname { "Pluto" }
  end

  trait :student_secondary do
    role { 'student_secondary' }
  end

  trait :student_university do
    role { 'student_university' }
  end

  trait :teacher do
    role { 'teacher' }
  end
end
