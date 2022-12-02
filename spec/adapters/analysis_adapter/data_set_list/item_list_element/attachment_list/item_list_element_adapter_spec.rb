describe AnalysisAdapter::DataSetList::ItemListElement::AttachmentList::ItemListElementAdapter do
  let(:analysis) { create :analysis, :with_realistic_attributes, element_id: 1, attachments: [attachment] }
  let(:attachment) { build :attachment, :with_realistic_attributes }
  let(:item_list_element_adapter) { described_class.new analysis, attachment }

  before do
    attachment
  end

  describe ".new" do
    subject { item_list_element_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { item_list_element_adapter.to_h }

    let(:expected_hash) do
      {
        filename: item_list_element_adapter.filename,
        filepath: item_list_element_adapter.filepath,
        identifier: item_list_element_adapter.identifier,
        type: item_list_element_adapter.type
      }
    end

    it { is_expected.to eq expected_hash }
  end

  describe "#type" do
    subject { item_list_element_adapter.type }

    it { is_expected.to eq "AttachmentEntity" }
    it { is_expected.to be_a String }
  end

  describe "#identifier" do
    subject { item_list_element_adapter.identifier }

    it { is_expected.to eq attachment.identifier }
    it { is_expected.to be_a String }
  end

  describe "#filename" do
    subject { item_list_element_adapter.filename }

    it { is_expected.to eq analysis.attachments.first.filename }
    it { is_expected.to be_a String }
  end

  describe "#filepath" do
    subject { item_list_element_adapter.filepath }

    let(:expected_file_path) { "data/#{analysis.chemotion_id}" }

    it { is_expected.to eq expected_file_path }
    it { is_expected.to be_a String }
  end
end
