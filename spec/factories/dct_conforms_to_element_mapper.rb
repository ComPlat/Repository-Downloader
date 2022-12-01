FactoryBot.define do
  factory :dct_conforms_to_element_mapper, class: "ReactionMappers::ReagentsList::ItemListElement::DctConformsToElementMapper" do
    trait :with_all_args do
      type { "CreativeWork" }
      id { "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/" }
    end
  end
end
