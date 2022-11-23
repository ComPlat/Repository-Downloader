FactoryBot.define do
  factory :data_set_list_item_list_element_mapper, class: "AnalysisMappers::DataSetList::ItemListElementMapper" do
    trait :primitives do
      type { "DatasetEntity" }
      identifier { "12345" }
      name { "BJ68_1H" }
      add_attribute(:Instrument) { "Bruker 400 MHz" }
      descriptions { "Bruker 400 MHz" }
    end

    trait :with_all_args_nested_structures_as_mappers do
      primitives
      attachmentList { build :attachment_list_mapper, :with_all_args_nested_structures_as_mappers }
    end

    trait :with_all_args_nested_structures_as_hash do
      primitives
      attachmentList { attributes_for :attachment_list_mapper, :with_all_args_nested_structures_as_hash }
    end
  end
end
