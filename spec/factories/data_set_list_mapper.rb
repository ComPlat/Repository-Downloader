FactoryBot.define do
  factory :data_set_list_mapper do
    trait :with_all_args do
      numberOfItems { 1 }
      itemListElement { build :data_set_item_list_element_mapper, :with_all_args }
    end
  end
end
