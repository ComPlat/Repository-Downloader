describe AnalysisAdapter::DataSetList::ItemListElementAdapterIterator do
  let(:analysis) { create(:analysis, :with_realistic_attributes, element_id: 1) }
  let(:item_list_element_adapter_iterator) { described_class.new analysis }

  describe ".new" do
    subject { item_list_element_adapter_iterator }

    it { is_expected.to be_a described_class }
  end

  describe "#to_a" do
    subject { item_list_element_adapter_iterator.to_a }

    let(:attachment) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 2, ds_id: 3 }
    let(:item_list_element_adapter) { AnalysisAdapter::DataSetList::ItemListElementAdapter.new analysis, attachment.ds_id, [attachment] }

    let(:expected_array) do
      [{type: item_list_element_adapter.type,
        descriptions: item_list_element_adapter.descriptions,
        identifier: item_list_element_adapter.identifier,
        name: item_list_element_adapter.name,
        Instrument: item_list_element_adapter.Instrument,
        attachmentList: item_list_element_adapter.attachmentList}]
    end

    before do
      attachment
    end

    it { is_expected.to eq expected_array }
  end
end
