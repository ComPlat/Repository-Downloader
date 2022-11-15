describe AnalysisToAnalysisMapperAdapter do
  let(:analysis) { create :analysis, :with_realistic_attributes, element_id: 1 }
  let(:analysis_to_analysis_mapper_adapter) { described_class.new analysis }

  describe ".new" do
    subject { analysis_to_analysis_mapper_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { analysis_to_analysis_mapper_adapter.to_h }

    let(:expected_hash) {
      {context: "https://schema.org/",
       datasetList: {},
       descriptions: "",
       id: "",
       identifier: "",
       ontologies: "",
       title: "",
       type: "AnalysisEntity",
       url: ""}
    }

    it { is_expected.to eq expected_hash }
  end

  describe "#context" do
    subject { analysis_to_analysis_mapper_adapter.context }

    it { is_expected.to eq "https://schema.org/" }
  end

  describe "#ontologies" do
    subject(:ontologies) { analysis_to_analysis_mapper_adapter.ontologies }

    it { is_expected.to eq "13C nuclear magnetic resonance spectroscopy (13C NMR)" }
    it { expect(analysis.extended_metadata.to_s).to include ontologies }
  end

  describe "#title" do
    subject(:title) { analysis_to_analysis_mapper_adapter.title }

    it { is_expected.to eq "NMR/13C/DMSO/100 (3-methyl-N-(7-(trifluoromethyl)-1H-indazol-3-yl)butanamide)" }
    it { expect(analysis.metadata_xml).to include title }
  end

  describe "#url" do
    subject(:url) { analysis_to_analysis_mapper_adapter.url }

    it { is_expected.to eq "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1" }
    it { is_expected.to include analysis.taggable_data["doi"] }
    it { is_expected.to include analysis.taggable_data["analysis_doi"] }
  end

  describe "#dataset_list" do
    subject(:dataset_list) { analysis_to_analysis_mapper_adapter.dataset_list }

    let(:attachment1_dataset1) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 2, ds_id: 4 }
    let(:attachment1_dataset2) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 3, ds_id: 5 }
    let(:attachment2_dataset2) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 6, ds_id: 5 }

    let(:expected_hash) do
      {itemListElement: [{Instrument: " Bruker",
                          attachmentList: {itemListElement: [{filename: "JK20-proton.peak.png",
                                                              filepath: "data/CRD-2913",
                                                              identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
                                                              type: "AttachmentEntity"}],
                                           numberOfItems: 1},
                          descriptions: "",
                          identifier: 4,
                          name: "BJ68_1H",
                          type: "DatasetEntity"},
        {Instrument: " Bruker",
         attachmentList: {itemListElement: [{filename: "JK20-proton.peak.png",
                                             filepath: "data/CRD-2913",
                                             identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
                                             type: "AttachmentEntity"},
           {filename: "JK20-proton.peak.png",
            filepath: "data/CRD-2913",
            identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
            type: "AttachmentEntity"}],
                          numberOfItems: 2},
         descriptions: "",
         identifier: 5,
         name: "BJ68_1H",
         type: "DatasetEntity"}],
       numberOfItems: 3}
    end

    before do
      attachment1_dataset1
      attachment1_dataset2
      attachment2_dataset2
    end

    it { is_expected.to eq expected_hash }
  end
end
