describe SampleAdapter::AnalysisList::ItemListElementAdapterIterator do
  let(:sample) {
    create :sample, :with_required_dependencies, :with_realistic_attributes,
      taggable_data: {"original_analysis_ids" => [attachment.analysis.id]}
  }
  let(:attachment) { create :attachment, :with_required_dependencies, :with_realistic_attributes }
  let(:item_list_element_adapter_iterator) { described_class.new sample }

  describe ".new" do
    subject { item_list_element_adapter_iterator }

    it { is_expected.to be_a described_class }
  end

  describe "#to_a" do
    subject { item_list_element_adapter_iterator.to_a }

    let(:analysis_to_analysis_mapper_adapter) { RootAdapters::AnalysisToAnalysisMapperAdapter.new attachment.analysis }

    let(:expected_array) do
      [{context: analysis_to_analysis_mapper_adapter.context,
        datasetList: analysis_to_analysis_mapper_adapter.datasetList,
        descriptions: analysis_to_analysis_mapper_adapter.descriptions,
        id: analysis_to_analysis_mapper_adapter.id,
        identifier: analysis_to_analysis_mapper_adapter.identifier,
        ontologies: analysis_to_analysis_mapper_adapter.ontologies,
        title: analysis_to_analysis_mapper_adapter.title,
        type: analysis_to_analysis_mapper_adapter.type,
        url: analysis_to_analysis_mapper_adapter.url}]
    end

    before do
      attachment.analysis
    end

    it { is_expected.to eq expected_array }
    it { is_expected.to be_a Array }
  end
end
