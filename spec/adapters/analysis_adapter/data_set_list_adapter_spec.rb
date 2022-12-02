describe AnalysisAdapter::DataSetListAdapter do
  let(:analysis) { build(:analysis, :with_realistic_attributes, element_id: 1) }
  let(:attachment1) { build :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 2, ds_id: 3 }
  let(:attachment2) { build :attachment, :with_realistic_attributes, ana_id: analysis.element_id, att_id: 4, ds_id: 5 }
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
        numberOfItems: data_set_list_adapter.numberOfItems,
        itemListElement: data_set_list_adapter.itemListElement
      }
    end

    it { is_expected.to eq expected_hash }
  end

  describe "#numberOfItems" do
    subject { data_set_list_adapter.numberOfItems }

    it { is_expected.to eq analysis.attachments.size }
  end

  describe "#itemListElement" do
    subject { data_set_list_adapter.itemListElement }

    it { is_expected.to eq AnalysisAdapter::DataSetList::ItemListElementAdapterIterator.new(analysis).to_a }
  end
end
