describe SampleAdapter::AnalysisList::ItemListElementAdapterIterator do
  let(:sample) {
    create :sample, :with_required_dependencies, :with_realistic_attributes,
      taggable_data: {"original_analysis_ids" => [analysis1.id]}
  }
  let(:analysis1) { create :analysis, :with_realistic_attributes, id: 1 }
  let(:item_list_element_adapter_iterator) { described_class.new sample }

  describe ".new" do
    subject { item_list_element_adapter_iterator }

    it { is_expected.to be_a described_class }
  end

  describe "#to_a" do
    subject { item_list_element_adapter_iterator.to_a }

    before do
      analysis1
    end

    let(:expected_array) do
      [{context: "https://schema.org/",
        datasetList: {itemListElement: [], numberOfItems: 0},
        descriptions: "{\"ops\":[{\"insert\":\" \"}, {\"attributes\":{\"script\":\"super\"},\"insert\":\"13\"}, {\"insert\":\"C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). \"}]}",
        id: "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
        identifier: "CRD-1",
        ontologies: "13C nuclear magnetic resonance spectroscopy (13C NMR)",
        title: "13C nuclear magnetic resonance spectroscopy (13C NMR)",
        type: "AnalysisEntity",
        url: "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1"}]
    end

    it { is_expected.to eq expected_array }
    it { is_expected.to be_a Array }
  end
end
