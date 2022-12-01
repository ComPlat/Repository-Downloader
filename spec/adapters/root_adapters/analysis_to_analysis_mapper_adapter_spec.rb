describe RootAdapters::AnalysisToAnalysisMapperAdapter do
  let(:analysis) { build :analysis, :with_realistic_attributes, element_id: 1 }
  let(:attachment) { build :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 2, ds_id: 3 }
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
    subject { analysis_to_analysis_mapper_adapter.id }

    context "when taggable_data is filled correctly" do
      it { is_expected.to eq "https://dx.doi.org/#{analysis.doi}" }
      it { is_expected.to be_a String }
    end

    context "when taggable_data is nil" do
      let(:analysis) { build :analysis, :with_realistic_attributes, taggable_data: nil }

      it { is_expected.to eq "" }
      it { is_expected.to be_a String }
    end
  end

  describe "#ontologies" do
    subject(:ontologies) { analysis_to_analysis_mapper_adapter.ontologies }

    it { expect(ontologies).to eq "13C nuclear magnetic resonance spectroscopy (13C NMR)" }
    # noinspection RubyResolve
    it { expect(analysis.extended_metadata.to_s).to include ontologies }
    it { is_expected.to be_a String }
  end

  describe "#descriptions" do
    subject(:descriptions) { analysis_to_analysis_mapper_adapter.descriptions }

    it { expect(descriptions).to eq analysis.content }
  end

  describe "#title" do
    subject(:title) { analysis_to_analysis_mapper_adapter.title }

    it { is_expected.to eq "13C nuclear magnetic resonance spectroscopy (13C NMR)" }
    # noinspection RubyResolve
    it { expect(analysis.extended_metadata.to_s).to include title }
    it { is_expected.to be_a String }
  end

  describe "#url" do
    subject(:url) { analysis_to_analysis_mapper_adapter.url }

    it { is_expected.to eq "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1" }
    it { is_expected.to include analysis.taggable_data["doi"] }
    it { is_expected.to include analysis.taggable_data["analysis_doi"] }
    it { is_expected.to be_a String }
  end

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
