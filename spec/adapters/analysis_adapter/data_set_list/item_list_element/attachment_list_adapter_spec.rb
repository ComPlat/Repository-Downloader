describe AnalysisAdapter::DataSetList::ItemListElement::AttachmentListAdapter do
  let(:attachment1) { build :attachment, :with_required_dependencies, :with_realistic_attributes, ds_id: 3 }
  let(:attachment2) { build :attachment, :with_realistic_attributes, ana_id: attachment1.ana_id, ds_id: 3, filename: "tstnm" }
  let(:attachments_grouped_by_dataset) { AttachmentRepository.grouped_by_dataset attachment1.analysis }
  let(:attachment_list_adapter) { described_class.new attachment1.analysis, attachments_grouped_by_dataset[attachment1.ds_id] }

  before do
    attachment1
    attachment2
  end

  describe ".new" do
    subject { attachment_list_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { attachment_list_adapter.to_h }

    let(:expected_hash) do
      {numberOfItems: attachment_list_adapter.numberOfItems,
       itemListElement: attachment_list_adapter.itemListElement}
    end

    it { is_expected.to eq expected_hash }
  end

  describe "#numberOfItems" do
    subject { attachment_list_adapter.numberOfItems }

    it { is_expected.to eq attachments_grouped_by_dataset[attachment1.ds_id].size }
  end

  describe "#itemListElement" do
    subject { attachment_list_adapter.itemListElement }

    let(:item_list_element_adapter) {
      AnalysisAdapter::DataSetList::ItemListElement::AttachmentList::ItemListElementAdapterIterator
        .new attachment1.analysis, attachments_grouped_by_dataset[attachment1.ds_id]
    }

    it { is_expected.to eq item_list_element_adapter.to_a }
  end
end
