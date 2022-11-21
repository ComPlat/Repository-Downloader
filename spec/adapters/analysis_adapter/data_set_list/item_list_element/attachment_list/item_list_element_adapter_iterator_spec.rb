describe AnalysisAdapter::DataSetList::ItemListElement::AttachmentList::ItemListElementAdapterIterator do
  let(:analysis) { create(:analysis, :with_realistic_attributes, element_id: 1) }
  let(:item_list_element_adapter_iterator) { described_class.new analysis }

  describe ".new" do
    subject { item_list_element_adapter_iterator }

    it { is_expected.to be_a described_class }
  end

  describe "#to_a" do
    subject { item_list_element_adapter_iterator.to_a }

    let(:attachment1) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 2, ds_id: 3 }

    let(:expected_array) do
      [{
        filename: "JK20-proton.peak.png",
        filepath: "data/CRD-2913",
        identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
        type: "AttachmentEntity"
      }]
    end

    before do
      attachment1
    end

    it { is_expected.to eq expected_array }
  end
end
