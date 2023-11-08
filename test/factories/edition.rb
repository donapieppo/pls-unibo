FactoryBot.define do
  factory :edition do 
    name { "Metodi matematici per l'animazione" }
    academic_year { 2022 }
    project
    audience
  end

  trait :bookable_in_presence do
    bookable { "yes" }
    in_presence { true }
    bookable_by_student_secondary { true }
    booking_start { Date.today - 3.days }
    booking_end { Date.tomorrow }
  end
end
