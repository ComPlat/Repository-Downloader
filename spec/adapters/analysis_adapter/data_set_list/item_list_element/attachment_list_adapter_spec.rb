describe AnalysisAdapter::DataSetList::ItemListElement::AttachmentListAdapter do
  let(:analysis) { create(:analysis, :with_realistic_attributes, element_id: 1) }
  let(:attachment1) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 2, ds_id: 3 }
  let(:attachments) { AttachmentRepository.grouped_by_dataset(analysis) }
  let(:attachment_list_adapter) { described_class.new analysis, attachments }

  before do
    attachment1
  end

  describe ".new" do
    subject { attachment_list_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { attachment_list_adapter.to_h }

    let(:expected_hash) do
      {
        numberOfItems: 1,
        itemListElement: [
          {filename: "JK20-proton.peak.png",
           filepath: "data/CRD-2913",
           identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
           type: "AttachmentEntity"}
        ]
      }
    end

    it { is_expected.to eq expected_hash }
  end

  describe "#numberOfItems" do
    subject { attachment_list_adapter.numberOfItems }

    it { is_expected.to eq analysis.attachments.count }
  end

  describe "#itemListElement" do
    subject { attachment_list_adapter.itemListElement }

    let(:expected_array) do
      [
        {filename: "JK20-proton.peak.png",
         filepath: "data/CRD-2913",
         identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
         type: "AttachmentEntity"}
      ]
    end

    it { is_expected.to eq expected_array }
  end
end
