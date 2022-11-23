FactoryBot.define do
  factory :analysis_mapper, class: "RootMappers::AnalysisMapper" do
    trait :primitives do
      add_attribute(:context) { "https://schema.org/" } # HINT: Otherwise Rubocop is confused.
      type { "AnalysisEntity" }
      id { "https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595" }
      ontologies { "13C nuclear magnetic resonance spectroscopy (13C NMR)" }
      title { "13C nuclear magnetic resonance spectroscopy (13C NMR) (4-(2-oxo-2-phenylacetyl)benzoic acid)" }
      descriptions { "13C NMR (100 MHz, DMSO-d6, ppm) δ = 194.2 (s, Cq), 194.1 (s, Cq), 166.3 (s, Cq), 135.7 (s, 2 x Cq), 135.1 (s, Cq), 132.0 (s, CarH), 130.1 (s, 2 x CarH), 129.9 (s, 2 x CarH), 129.8 (s, 2 x CarH), 129.5 (s, 2 x CarH)." }
      url { "https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595" }
      identifier { "CRD-27923" }
    end

    trait :with_all_args_nested_structures_as_mappers do
      primitives
      datasetList { build :data_set_list_mapper, :with_all_args_nested_structures_as_mappers }
    end

    trait :with_all_args_nested_structures_as_hash do
      primitives
      datasetList { attributes_for :data_set_list_mapper, :with_all_args_nested_structures_as_hash }
    end
  end
end
