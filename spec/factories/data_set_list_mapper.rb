FactoryBot.define do
  factory :data_set_list_mapper, class: "AnalysisMappers::DataSetListMapper" do
    trait :primitives do
      numberOfItems { itemListElement.size }
    end

    trait :with_all_args_nested_structures_as_mappers do
      primitives
      itemListElement { [build(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_mappers)] }
    end

    trait :with_all_args_nested_structures_as_hash do
      primitives
      itemListElement { [attributes_for(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_hash)] }
    end
  end
end
