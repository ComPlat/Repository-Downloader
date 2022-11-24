describe RootAdapters::AnalysisToAnalysisMapperAdapter do
  let(:analysis) { create :analysis, :with_realistic_attributes, element_id: 1 }
  let(:attachment) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 2, ds_id: 3 }
  let(:analysis_to_analysis_mapper_adapter) { described_class.new analysis }

  before do
    attachment
  end

  describe ".new" do
    subject { analysis_to_analysis_mapper_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject(:to_h) { analysis_to_analysis_mapper_adapter.to_h }

    let(:expected_hash) do
      {context: analysis_to_analysis_mapper_adapter.context,
       descriptions: analysis_to_analysis_mapper_adapter.descriptions,
       id: analysis_to_analysis_mapper_adapter.id,
       identifier: analysis_to_analysis_mapper_adapter.identifier,
       ontologies: analysis_to_analysis_mapper_adapter.ontologies,
       title: analysis_to_analysis_mapper_adapter.title,
       type: analysis_to_analysis_mapper_adapter.type,
       url: analysis_to_analysis_mapper_adapter.url,
       datasetList: analysis_to_analysis_mapper_adapter.datasetList}
    end

    it { expect(to_h).to eq expected_hash }
  end

  describe "#context" do
    subject { analysis_to_analysis_mapper_adapter.context }

    it { is_expected.to eq "https://schema.org/" }
  end

  describe "#type" do
    subject { analysis_to_analysis_mapper_adapter.type }

    it { is_expected.to eq "AnalysisEntity" }
  end

  describe "#id" do
    context "when analysis is given" do
      subject { analysis_to_analysis_mapper_adapter.id }

      it { is_expected.to eq "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1" }
    end

    context "when analysis is NOT given" do
      subject { analysis_to_analysis_mapper_adapter.id }

      let(:analysis) { create :analysis, :with_realistic_attributes, taggable_data: nil }

      it { is_expected.to eq "" }
    end
  end

  describe "#ontologies" do
    subject(:ontologies) { analysis_to_analysis_mapper_adapter.ontologies }

    it { expect(ontologies).to eq "13C nuclear magnetic resonance spectroscopy (13C NMR)" }
    # noinspection RubyResolve
    it { expect(analysis.extended_metadata.to_s).to include ontologies }
  end

  describe "#descriptions" do
    subject(:descriptions) { analysis_to_analysis_mapper_adapter.descriptions }

    let(:expected_description) do
      "{\"ops\":[{\"insert\":\" \"}, {\"attributes\":{\"script\":\"super\"},\"insert\":\"13\"}, {\"insert\":\"C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). \"}]}"
    end

    it { expect(descriptions).to eq_without_whitespace expected_description }
    # noinspection RubyResolve
    it { expect(analysis.extended_metadata["content"].to_s).to include descriptions.to_s }
  end

  describe "#title" do
    subject(:title) { analysis_to_analysis_mapper_adapter.title }

    it { is_expected.to eq "13C nuclear magnetic resonance spectroscopy (13C NMR)" }
    # noinspection RubyResolve
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

    let(:data_set_list_adapter) { AnalysisAdapter::DataSetListAdapter.new analysis }

    let(:expected_hash) do
      {numberOfItems: data_set_list_adapter.numberOfItems,
       itemListElement: data_set_list_adapter.itemListElement}
    end

    it { expect(dataset_list).to eq expected_hash }
  end
end
