describe AnalysisAdapter::DataSetList::ItemListElement::AttachmentList::ItemListElementAdapterIterator do
  let(:attachment1) { create(:attachment, :with_required_dependencies, :with_realistic_attributes, ds_id: 3) }
  let(:attachment2) { create(:attachment, :with_realistic_attributes, ana_id: attachment1.ana_id, ds_id: 3) }
  let(:attachments_grouped_by_dataset) { AttachmentRepository.grouped_by_dataset attachment1.analysis }

  describe ".new" do
    subject { described_class.new attachment1.analysis, attachments_grouped_by_dataset[attachment1.ds_id] }

    it { is_expected.to be_a described_class }
  end

  describe "#to_a" do
    subject { described_class.new(attachment1.analysis, attachments_grouped_by_dataset[attachment1.ds_id]).to_a }

    let(:item_list_element_adapter1) {
      AnalysisAdapter::DataSetList::ItemListElement::AttachmentList::ItemListElementAdapter.new attachment1.analysis, attachment1
    }
    let(:item_list_element_adapter2) {
      AnalysisAdapter::DataSetList::ItemListElement::AttachmentList::ItemListElementAdapter.new attachment1.analysis, attachment2
    }

    before do
      attachment1
      attachment2
    end

    it { is_expected.to eq [item_list_element_adapter1.to_h, item_list_element_adapter2.to_h] }
    it { is_expected.to be_a Array }
  end
end
