FactoryBot.define do
  factory :data_set_list_mapper, class: "AnalysisMapper::DataSetListMapper" do
    trait :with_all_args_nested_structures_as_mappers do
      numberOfItems { 1 }
      itemListElement { [build(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_mappers)] }
    end

    trait :with_all_args_nested_structures_as_hash do
      numberOfItems { 1 }
      itemListElement { [attributes_for(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_hash)] }
    end
  end
end
