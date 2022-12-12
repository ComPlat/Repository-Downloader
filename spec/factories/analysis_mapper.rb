FactoryBot.define do
  factory :analysis_mapper, class: "RootMappers::AnalysisMapper" do
    trait :primitives do
      add_attribute(:context) { "https://schema.org/" } # HINT: Otherwise Rubocop is confused.
      type { "AnalysisEntity" }
      id { "https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595" }
      ontologies { "13C nuclear magnetic resonance spectroscopy (13C NMR)" }
      title { "13C nuclear magnetic resonance spectroscopy (13C NMR) (4-(2-oxo-2-phenylacetyl)benzoic acid)" }
      descriptions { {"ops" => [{"insert" => " "}, {"attributes" => {"script" => "super"}, "insert" => "13"}, {"insert" => "C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]} }
      url { "https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595" }
      identifier { "CRD-27923" }
    end

    trait :with_all_args_nested_structures_as_mappers do
      primitives
      datasetList { build(:data_set_list_mapper, :with_all_args_nested_structures_as_mappers) }
    end

    trait :with_all_args_nested_structures_as_hash do
      primitives
      datasetList { attributes_for(:data_set_list_mapper, :with_all_args_nested_structures_as_hash) }
    end
  end
end
