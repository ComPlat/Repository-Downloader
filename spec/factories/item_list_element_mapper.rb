FactoryBot.define do
  factory :item_list_element_mapper do
    let(:type_attr) { "@type" }
    let(:instrument_attr) { "Instrument" }

    trait :with_all_args do
      type_attr { "DatasetEntity" }
      identifier { "12345" }
      filename { "BJ68_1H.zip" }
      filepath { "data/a63e278b-22f2-4da3-955f-e80e197bc853" }
      name { "BJ68_1H" }
      instrument_attr { "Bruker 400 MHz" }
      descriptions { "Bruker 400 MHz" }
      attachmentList { build :attachment_list_mapper, :with_all_args }
    end

    trait :data_set_list_args do
      type_attr { "DatasetEntity" }
      identifier { "12345" }
      filename { nil }
      filepath { nil }
      name { "BJ68_1H" }
      instrument_attr { "Bruker 400 MHz" }
      descriptions { "Bruker 400 MHz" }
      attachmentList { build :attachment_list_mapper, :with_all_args }
    end

    trait :attachment_list_args do
      type_attr { "DatasetEntity" }
      identifier { "12345" }
      filename { "BJ68_1H.zip" }
      filepath { "data/a63e278b-22f2-4da3-955f-e80e197bc853" }
      name { nil }
      instrument_attr { nil }
      descriptions { nil }
      attachmentList { nil }
    end
  end
end
