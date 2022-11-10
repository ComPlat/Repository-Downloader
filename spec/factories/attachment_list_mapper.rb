FactoryBot.define do
  factory :attachment_list_mapper do
    trait :with_all_args do
      numberOfItems { 1 }
      itemListElement { build :attachment_list_item_list_element_mapper, :with_all_args }
    end
  end
end
