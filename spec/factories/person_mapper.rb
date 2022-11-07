FactoryBot.define do
  factory :person_mapper do
    trait :with_all_args do
      first_name { "John" }
      last_name { "Doe" }
      age { 25 }
      married { true }
      hobbies { %w[Guitar Music Reading] }
      address { build :address_mapper, :with_all_args }
    end
  end
end
