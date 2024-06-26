FactoryBot.define do
  factory :molecular_weight_mapper, class: "SampleMappers::MolecularWeightMapper" do
    trait :with_all_args do
      value { 218.20870000000002 }
    end
  end
end
