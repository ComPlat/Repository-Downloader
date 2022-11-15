FactoryBot.define do
  factory :dct_list_mapper do
    trait :with_all_args do
      type { "CreativeWork" }
      id { "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/" }
    end
  end
end
