FactoryBot.define do
  factory :dct_element_mapper, class: "SampleMappers::DctElementMapper" do
    trait :with_all_args_nested_structures_as_mappers do
      dct_conformsTo { build :dct_list_mapper, :with_all_args }
    end

    trait :with_all_args_nested_structures_as_hash do
      dct_conformsTo { attributes_for :dct_list_mapper, :with_all_args }
    end
  end
end
