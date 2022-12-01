describe SampleAdapter::AnalysisListAdapter do
  let(:sample) { build :sample, :with_required_dependencies, :with_realistic_attributes }
  let(:analysis_list_adapter) { described_class.new sample }

  describe ".new" do
    subject { analysis_list_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { analysis_list_adapter.to_h }

    it { is_expected.to eq({itemListElement: analysis_list_adapter.itemListElement, numberOfItems: analysis_list_adapter.numberOfItems}) }
  end

  describe "#numberOfItems" do
    subject { analysis_list_adapter.numberOfItems }

    it { is_expected.to eq sample.analyses.size }
  end

  describe "#itemListElement" do
    subject { analysis_list_adapter.itemListElement }

    it { is_expected.to eq SampleAdapter::AnalysisList::ItemListElementAdapterIterator.new(sample).to_a }
  end
end
