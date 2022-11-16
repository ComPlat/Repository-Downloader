FactoryBot.define do
  factory :reagents_list_mapper do
    trait :with_all_args do
      numberOfItems { 1 }
      itemListElement { build :reagents_list_item_list_element_mapper, :with_all_args }
    end
  end
end
