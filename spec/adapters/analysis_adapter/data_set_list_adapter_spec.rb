describe AnalysisAdapter::DataSetListAdapter do
  let(:analysis) { create(:analysis, :with_realistic_attributes, element_id: 1) }
  let(:attachment1) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 2, ds_id: 3 }
  let(:attachment2) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 4, ds_id: 5 }
  let(:data_set_list_adapter) { described_class.new analysis }

  before do
    attachment1
    attachment2
  end

  describe ".new" do
    subject { data_set_list_adapter }

    it { is_expected.to be_a described_class }
  end

  describe ".to_h" do
    subject { data_set_list_adapter.to_h }

    let(:expected_hash) do
      {
        numberOfItems: 2,
        itemListElement: [
          {Instrument: " Bruker",
           attachmentList: {
             numberOfItems: 1,
             itemListElement: [
               {
                 filename: "JK20-proton.peak.png",
                 filepath: "data/CRD-2913",
                 identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
                 type: "AttachmentEntity"
               },
               {
                 filename: "JK20-proton.peak.png",
                 filepath: "data/CRD-2913",
                 identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
                 type: "AttachmentEntity"
               }
             ]
           },
           descriptions: "",
           identifier: 3,
           name: "BJ68_1H",
           type: "DatasetEntity"},
          {Instrument: " Bruker",
           attachmentList: {
             numberOfItems: 1,
             itemListElement: [
               {
                 filename: "JK20-proton.peak.png",
                 filepath: "data/CRD-2913",
                 identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
                 type: "AttachmentEntity"
               },
               {
                 filename: "JK20-proton.peak.png",
                 filepath: "data/CRD-2913",
                 identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
                 type: "AttachmentEntity"
               }
             ]
           },
           descriptions: "",
           identifier: 5,
           name: "BJ68_1H",
           type: "DatasetEntity"}
        ]
      }
    end

    it { is_expected.to eq expected_hash }
  end

  describe "#numberOfItems" do
    subject { data_set_list_adapter.numberOfItems }

    it { is_expected.to eq analysis.attachments.count }
  end

  describe "#itemListElement" do
    subject { data_set_list_adapter.itemListElement }

    it { is_expected.to eq AnalysisAdapter::DataSetList::ItemListElementAdapterIterator.new(analysis).to_a }
  end
end
