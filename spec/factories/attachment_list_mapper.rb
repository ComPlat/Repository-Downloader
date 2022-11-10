FactoryBot.define do
  factory :attachment_list_mapper do
    trait :with_all_args do
      numberOfItems { 2 }
      itemListElement { build :item_list_element_mapper, :attachment_list_args }
    end
  end
end
