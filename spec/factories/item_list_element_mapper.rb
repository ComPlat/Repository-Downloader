FactoryBot.define do
  factory :item_list_element_mapper do
    trait :with_all_args do
      add_attribute(:id) { "DatasetEntity" }
      identifier { "12345" }
      filename { "BJ68_1H.zip" }
      filepath { "data/a63e278b-22f2-4da3-955f-e80e197bc853" }
      name { "BJ68_1H" }
      add_attribute(:Instrument) { "Bruker 400 MHz" }
      descriptions { "Bruker 400 MHz" }
      attachmentList { build :attachment_list_mapper, :with_all_args }
    end

    trait :data_set_list_args do
      add_attribute(:id) { "DatasetEntity" }
      identifier { "12345" }
      filename { nil }
      filepath { nil }
      name { "BJ68_1H" }
      add_attribute(:Instrument) { "Bruker 400 MHz" }
      descriptions { "Bruker 400 MHz" }
      attachmentList { build :attachment_list_mapper, :with_all_args }
    end

    trait :attachment_list_args do
      add_attribute(:id) { "DatasetEntity" }
      identifier { "12345" }
      filename { "BJ68_1H.zip" }
      filepath { "data/a63e278b-22f2-4da3-955f-e80e197bc853" }
      name { nil }
      add_attribute(:Instrument) { "Bruker 400 MHz" }
      descriptions { nil }
      attachmentList { nil }
    end
  end
end
