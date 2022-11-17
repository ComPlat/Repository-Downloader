FactoryBot.define do
  factory :sample_mapper do
    trait :with_all_args do
      add_attribute(:context) { "https://schema.org/" } # HINT: Otherwise Rubocop is confused.
      type { "MolecularEntity" }
      dct_conformsTo { build :dct_element_mapper, :with_all_args_nested_structures_as_mappers }
      id { "10.14272/MIIFHRBUBUHJMC-UHFFFAOYSA-N.1" }
      name { "ethyl 3-oxo-4H-quinoxaline-2-carboxylate" }
      url { "http://chemotion-repository.net/home/publications/molecules/6338" }
      identifier { "chemotion ID ?" }
      iupacName { "ethyl 3-oxo-4H-quinoxaline-2-carboxylate" }
      smiles { "CCOC(=O)c1nc2ccccc2nc1O" }
      inChI { "InChI=1S/C11H10N2O3/c1-2-16-11(15)9-10(14)13-8-6-4-3-5-7(8)12-9/h3-6H,2H2,1H3,(H,13,14)" }
      inChIKey { "MIIFHRBUBUHJMC-UHFFFAOYSA-N" }
      molecularFormula { "C11H10N2O3" }
      meltingPoint { "10 - 20 °C" }
      boilingPoint { "20 °C" }
      molecularWeight { build :molecular_weight_mapper, :with_all_args }
      analysisList { build :analysis_list_mapper, :with_all_args_nested_structures_as_mappers }
    end
  end
end
