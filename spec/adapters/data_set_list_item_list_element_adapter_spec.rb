describe DataSetListItemListElementAdapter do
  let(:analysis) { create :analysis, :with_realistic_attributes, element_id: 1 }
  let(:data_set_list_adapter) { described_class.new analysis }

  describe ".new" do
    subject { data_set_list_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#itemListElement" do
    subject(:itemListElement) { data_set_list_adapter.itemListElement }

    let(:attachment1_dataset1) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 2, ds_id: 4 }

    context "with NO attachments" do
      it { is_expected.to eq([]) }
    end

    context "with ONE attachment" do
      let(:expected_array) do
        [{Instrument: " Bruker",
          attachmentList: {itemListElement: [{filename: "JK20-proton.peak.png",
                                              filepath: "data/CRD-2913",
                                              identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
                                              type: "AttachmentEntity"}],
                           numberOfItems: 1},
          descriptions: "",
          identifier: 4,
          name: "BJ68_1H",
          type: "DatasetEntity"}]
      end

      before do
        attachment1_dataset1
      end

      # it { is_expected.to eq expected_array }
      it {
        expect(itemListElement.to_json).to eq expected_array
      }
    end

    context "with three attachments, two with identical ds_id" do
      let(:attachments) {
        [(create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 3, ds_id: 5),
          (create :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 6, ds_id: 5)]
      }

      let(:expected_array) do
        [{Instrument: " Bruker",
          attachmentList: {itemListElement: [{filename: "JK20-proton.peak.png",
                                              filepath: "data/CRD-2913",
                                              identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
                                              type: "AttachmentEntity"}],
                           numberOfItems: 1},
          descriptions: "",
          identifier: 4,
          name: "BJ68_1H",
          type: "DatasetEntity"},
          {Instrument: " Bruker",
           attachmentList: {itemListElement: [{filename: "JK20-proton.peak.png",
                                               filepath: "data/CRD-2913",
                                               identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
                                               type: "AttachmentEntity"},
             {filename: "JK20-proton.peak.png",
              filepath: "data/CRD-2913",
              identifier: "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a",
              type: "AttachmentEntity"}],
                            numberOfItems: 2},
           descriptions: "",
           identifier: 5,
           name: "BJ68_1H",
           type: "DatasetEntity"}]
      end

      before do
        attachment1_dataset1
        attachments
      end

      it { is_expected.to eq expected_array }
    end
  end
end
