FactoryBot.define do
  factory :booking do 
    user
    activity factory: :edition 
  end

  trait :data_complete do
    teacher_name { 'Teacher name in booking' }
    teacher_surname { 'Teacher surname in booking' }
    teacher_email { 'teacher@example.com' }
  end
end
