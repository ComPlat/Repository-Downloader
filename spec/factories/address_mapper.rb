FactoryBot.define do
  factory :address_mapper do
    trait :with_all_args do
      # noinspection RubyResolve
      city { "city" }
      # noinspection RubyResolve
      street { "street" }
      zip { "zip" }
    end
  end
end
