FactoryBot.define do
  factory :analysis_list_mapper, class: "SampleMappers::AnalysisListMapper" do
    trait :primitives do
      numberOfItems { 1 }
    end

    trait :with_all_args_nested_structures_as_mappers do
      primitives
      itemListElement { [build(:analysis_mapper, :with_all_args_nested_structures_as_mappers)] }
    end

    trait :with_all_args_nested_structures_as_hash do
      primitives
      itemListElement { [attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_hash)] }
    end
  end
end
