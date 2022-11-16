FactoryBot.define do
  factory :reagents_list_item_list_element_mapper do
    trait :with_all_args do
      type { "MolecularEntity" }
      dct_conformsTo { build :dct_list_mapper, :with_all_args }
      id { "http://www.ebi.ac.uk/chebi/searchId.do?chebiId=CHEBI:15377" }
      identifier { "CHEBI:15377" }
      name { "H2O" }
      molecularFormula { "H2O" }
      inChIKey { "XLYOFNOQVPJJNP-UHFFFAOYSA-N" }
      smiles { "[H]O[H]" }
      image { "https://www.rhea-db.org/compoundImage?dimensions=200&chebiId=CHEBI:15377" }
    end
  end
end
