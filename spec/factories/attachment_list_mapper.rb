FactoryBot.define do
  factory :attachment_list_mapper, class: "AnalysisMappers::DataSetList::ItemListElement::AttachmentListMapper" do
    trait :with_all_args_nested_structures_as_mappers do
      numberOfItems { 2 }
      itemListElement {
        [(build :attachment_list_item_list_element_mapper, :with_all_args),
          (build :attachment_list_item_list_element_mapper, :with_all_args, filename: "HRMS.jpg")]
      }
    end

    trait :with_all_args_nested_structures_as_hash do
      numberOfItems { 2 }
      itemListElement {
        [(attributes_for :attachment_list_item_list_element_mapper, :with_all_args),
          (attributes_for :attachment_list_item_list_element_mapper, :with_all_args, filename: "HRMS.jpg")]
      }
    end
  end
end
