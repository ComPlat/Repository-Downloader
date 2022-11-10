FactoryBot.define do
  factory :attachment_list_item_list_element_mapper do
    trait :with_all_args do
      add_attribute(:type) { "DatasetEntity" }
      identifier { "12345" }
      filename { "BJ68_1H.zip" }
      filepath { "data/a63e278b-22f2-4da3-955f-e80e197bc853" }
      # attachmentList { nil }
    end
  end
end
