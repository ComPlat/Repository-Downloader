FactoryBot.define do
  factory :data_set_item_list_element_mapper do
    trait :with_all_args do
      add_attribute(:type) { "DatasetEntity" }
      identifier { "12345" }
      name { "BJ68_1H" }
      add_attribute(:Instrument) { "Bruker 400 MHz" }
      descriptions { "Bruker 400 MHz" }
      attachmentList { build :attachment_list_mapper, :with_all_args }
    end
  end
end
