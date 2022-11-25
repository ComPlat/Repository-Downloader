describe AnalysisAdapter::DataSetList::ItemListElement::AttachmentList::ItemListElementAdapter do
  let(:analysis) { create :analysis, :with_realistic_attributes, element_id: 1 }
  let(:attachment) {
    create :attachment,
      ds_id: 2,
      ana_id: analysis.element_id,
      identifier: "a63e278b-22f2-4da3-955f-e80e197bc853",
      filename: "BJ68_1H.zip"
  }
  let(:attachment_list_adapter) { described_class.new analysis, attachment.ds_id, [attachment] }

  describe ".new" do
    subject { attachment_list_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { attachment_list_adapter.to_h }

    let(:expected_hash) do
      {
        filename: attachment_list_adapter.filename,
        filepath: attachment_list_adapter.filepath,
        identifier: attachment_list_adapter.identifier,
        type: attachment_list_adapter.type
      }
    end

    it { is_expected.to eq expected_hash }
  end

  describe "#type" do
    subject { attachment_list_adapter.type }

    it { is_expected.to eq "AttachmentEntity" }
  end

  describe "#identifier" do
    subject { attachment_list_adapter.identifier }

    it { is_expected.to eq attachment.identifier }
  end

  describe "#filename" do
    subject { attachment_list_adapter.filename }

    it { is_expected.to eq "BJ68_1H.zip" }
  end

  describe "#filepath" do
    subject { attachment_list_adapter.filepath }

    let(:expected_file_path) { "data/#{analysis.chemotion_id}" }

    it { is_expected.to eq expected_file_path }
  end
end
