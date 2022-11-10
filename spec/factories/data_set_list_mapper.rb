FactoryBot.define do
  factory :data_set_list_mapper do
    trait :with_all_args do
      numberOfItems { 2 }
      itemListElement { build :item_list_element_mapper, :data_set_list_args }
    end
  end
end
