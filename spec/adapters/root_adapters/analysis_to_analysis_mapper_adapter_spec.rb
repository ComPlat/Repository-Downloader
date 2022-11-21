describe RootAdapters::AnalysisToAnalysisMapperAdapter do
  let!(:analysis) { create :analysis, :with_realistic_attributes, element_id: 1 }
  # rubocop:disable RSpec/LetSetup
  let!(:attachment1) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 2, ds_id: 3 }
  let!(:attachment2) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 4, ds_id: 5 }
  let!(:analysis_to_analysis_mapper_adapter) { described_class.new analysis }
  # rubocop:enable RSpec/LetSetup

  describe ".new" do
    subject { analysis_to_analysis_mapper_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject(:to_h) { analysis_to_analysis_mapper_adapter.to_h }

    let(:expected_hash) {
      {context: "https://schema.org/",
       datasetList:
          {itemListElement:
              [{Instrument: " Bruker", attachmentList:
                {itemListElement:
                    [{filename: "JK20-proton.peak.png", filepath: "data/CRD-2913", identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a", type: "AttachmentEntity"}],
                 numberOfItems: 1}, descriptions: "", identifier: 3, name: "BJ68_1H", type: "DatasetEntity"},
                {Instrument: " Bruker", attachmentList:
                  {itemListElement:
                      [{filename: "JK20-proton.peak.png", filepath: "data/CRD-2913", identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a", type: "AttachmentEntity"}],
                   numberOfItems: 1}, descriptions: "", identifier: 5, name: "BJ68_1H", type: "DatasetEntity"}],
           numberOfItems: 2},
       descriptions: "{\"ops\":[{\"insert\":\" \"}, {\"attributes\":{\"script\":\"super\"},\"insert\":\"13\"}, {\"insert\":\"C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). \"}]}",
       id: "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
       identifier: "CRD-2913",
       ontologies: "13C nuclear magnetic resonance spectroscopy (13C NMR)",
       title: "13C nuclear magnetic resonance spectroscopy (13C NMR)",
       type: "AnalysisEntity",
       url: "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1"}
    }

    it { expect(to_h).to eq expected_hash }
  end

  describe "#context" do
    subject { analysis_to_analysis_mapper_adapter.context }

    it { is_expected.to eq "https://schema.org/" }
  end

  describe "#ontologies" do
    subject(:ontologies) { analysis_to_analysis_mapper_adapter.ontologies }

    it { expect(ontologies).to eq "13C nuclear magnetic resonance spectroscopy (13C NMR)" }
    it { expect(analysis.extended_metadata.to_s).to include ontologies }
  end

  describe "#descriptions" do
    subject(:descriptions) { analysis_to_analysis_mapper_adapter.descriptions }

    let(:expected_description) do
      "{\"ops\":[{\"insert\":\" \"}, {\"attributes\":{\"script\":\"super\"},\"insert\":\"13\"}, {\"insert\":\"C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). \"}]}"
    end

    it { expect(descriptions).to eq_without_whitespace expected_description }
    it { expect(analysis.extended_metadata["content"].to_s).to include descriptions.to_s }
  end

  describe "#title" do
    subject(:title) { analysis_to_analysis_mapper_adapter.title }

    it { is_expected.to eq "13C nuclear magnetic resonance spectroscopy (13C NMR)" }
    it { expect(analysis.extended_metadata.to_s).to include title }
  end

  describe "#url" do
    subject(:url) { analysis_to_analysis_mapper_adapter.url }

    it { is_expected.to eq "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1" }
    it { is_expected.to include analysis.taggable_data["doi"] }
    it { is_expected.to include analysis.taggable_data["analysis_doi"] }
  end

  # TODO: test call to DataSetListAdapter
  describe "#datasetList" do
    subject(:dataset_list) { analysis_to_analysis_mapper_adapter.datasetList }

    let(:expected_hash) do
      {itemListElement:
          [{Instrument: " Bruker", attachmentList:
            {itemListElement:
                [{filename: "JK20-proton.peak.png", filepath: "data/CRD-2913", identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a", type: "AttachmentEntity"}],
             numberOfItems: 1}, descriptions: "", identifier: 3, name: "BJ68_1H", type: "DatasetEntity"},
            {Instrument: " Bruker", attachmentList:
              {itemListElement:
                  [{filename: "JK20-proton.peak.png", filepath: "data/CRD-2913", identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a", type: "AttachmentEntity"}],
               numberOfItems: 1}, descriptions: "", identifier: 5, name: "BJ68_1H", type: "DatasetEntity"}],
       numberOfItems: 2}
    end

    it { is_expected.to eq expected_hash }
  end
end
