FactoryBot.define do
  factory :analysis_list_mapper, class: "SampleMappers::AnalysisListMapper" do
    trait :with_all_args_nested_structures_as_mappers do
      numberOfItems { 1 }
      itemListElement { [build(:analysis_mapper, :with_all_args_nested_structures_as_mappers)] }
    end

    trait :with_all_args_nested_structures_as_hash do
      numberOfItems { 1 }
      itemListElement { [attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_hash)] }
    end
  end
end
