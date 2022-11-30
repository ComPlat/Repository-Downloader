describe AnalysisAdapter::DataSetList::ItemListElementAdapter do
  let(:attachment) { create :attachment, :with_required_dependencies, :with_realistic_attributes }
  let(:data_set_list_adapter) { described_class.new attachment.analysis, attachment.ds_id, [attachment] }

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

    it { is_expected.to eq attachment.ds_id }
  end

  describe "#name" do
    subject { data_set_list_adapter.name }

    it { is_expected.to eq attachment.name }
    it { is_expected.to be_a String }
  end

  describe "#Instrument" do
    subject { data_set_list_adapter.Instrument }

    it { is_expected.to eq attachment.instrument }
    it { is_expected.to be_a String }
  end

  describe "#descriptions" do
    subject { data_set_list_adapter.descriptions }

    it { is_expected.to eq attachment.ds_desc }
    it { is_expected.to be_a String }
  end

  describe "#attachmentList" do
    subject { data_set_list_adapter.attachmentList }

    let(:expected_hash) {
      AnalysisAdapter::DataSetList::ItemListElement::AttachmentListAdapter.new(attachment.analysis, [attachment]).to_h
    }

    it { is_expected.to eq expected_hash }
    it { is_expected.to be_a Hash }
  end
end
