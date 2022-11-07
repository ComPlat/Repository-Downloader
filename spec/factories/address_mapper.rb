FactoryBot.define do
  factory :address_mapper do
    trait :with_all_args do
      city { "city" }
      street { "street" }
      zip { "zip" }
    end
  end
end
