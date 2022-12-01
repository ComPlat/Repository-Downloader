FactoryBot.define do
  factory :dct_conforms_to_mapper, class: "SampleMappers::DctConformsToMapper" do
    trait :with_all_args_nested_structures_as_mappers do
      dct_conformsTo { build :dct_conforms_to_element_mapper, :with_all_args }
    end

    trait :with_all_args_nested_structures_as_hash do
      dct_conformsTo { attributes_for :dct_conforms_to_element_mapper, :with_all_args }
    end
  end
end
