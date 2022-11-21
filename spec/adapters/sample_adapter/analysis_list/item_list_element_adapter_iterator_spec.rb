describe SampleAdapter::AnalysisList::ItemListElementAdapterIterator do
  let(:sample) { build :sample, :with_realistic_attributes }
  let(:item_list_element_adapter_iterator) { described_class.new sample }

  describe ".new" do
    subject { item_list_element_adapter_iterator }

    it { is_expected.to be_a described_class }
  end

  # TODO: Implement me!
  describe "#to_a" do
  end
end
