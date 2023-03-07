describe SampleAdapter::AnalysisList::ItemListElementAdapter do
  let(:sample) {
    create(:sample, :with_required_dependencies, :with_realistic_attributes,
      taggable_data: {"original_analysis_ids" => analyses.pluck(:id)})
  }
  let(:analyses) { create_list(:analysis, 2, :with_realistic_attributes) }
  let(:item_list_element_adapter) { described_class.new analyses }

  describe ".new" do
    subject { item_list_element_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#itemListElement" do
    subject { item_list_element_adapter.itemListElement }

    it { is_expected.to be_a Array }
    it { is_expected.to eq SampleAdapter::AnalysisList::ItemListElementAdapterIterator.new(analyses).to_a }
  end
end
