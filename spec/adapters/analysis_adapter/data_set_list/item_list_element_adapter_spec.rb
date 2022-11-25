describe AnalysisAdapter::DataSetList::ItemListElementAdapter do
  let(:analysis) { create :analysis, :with_realistic_attributes, element_id: 1 }
  let(:data_set_attachment) {
    create :attachment,
      ds_id: 2,
      ana_id: analysis.element_id,
      identifier: "a63e278b-22f2-4da3-955f-e80e197bc853",
      filename: "BJ68_1H.zip",
      name: "BJ68_1H",
      ds_desc: "Bruker 400 MHz"
  }
  let(:data_set_list_adapter) { described_class.new analysis, data_set_attachment.ds_id, [data_set_attachment] }

  describe ".new" do
    subject { data_set_list_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#type" do
    subject { data_set_list_adapter.type }

    it { is_expected.to eq "DatasetEntity" }
  end

  describe "#identifier" do
    subject { data_set_list_adapter.identifier }

    it { is_expected.to eq data_set_attachment.ds_id }
  end

  describe "#name" do
    subject { data_set_list_adapter.name }

    it { is_expected.to eq data_set_attachment.name }
  end

  describe "#Instrument" do
    subject { data_set_list_adapter.Instrument }

    it { is_expected.to eq data_set_attachment.instrument }
    it { is_expected.to be_a String }
  end

  describe "#descriptions" do
    subject { data_set_list_adapter.descriptions }

    it { is_expected.to eq data_set_attachment.ds_desc }
  end

  describe "#attachmentList" do
    subject { data_set_list_adapter.attachmentList }

    let(:expected_hash) {
      AnalysisAdapter::DataSetList::ItemListElement::AttachmentListAdapter.new(analysis, [data_set_attachment]).to_h
    }

    it { is_expected.to eq expected_hash }
    it { is_expected.to be_a Hash }
  end
end
