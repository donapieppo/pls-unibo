FactoryBot.define do
  factory :school do 
    name { "Scuola" }
    sequence(:code) {|n| "codice#{n}"}
  end
end
