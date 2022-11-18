FactoryBot.define do
  factory :attachment_list_item_list_element_mapper, class: "AnalysisMapper::DataSetList::ItemListElement::AttachmentList::ItemListElementMapper" do
    trait :with_all_args do
      type { "AttachmentEntity" }
      identifier { "a63e278b-22f2-4da3-955f-e80e197bc853" }
      filename { "BJ68_1H.zip" }
      filepath { "data/a63e278b-22f2-4da3-955f-e80e197bc853" }
    end
  end
end
