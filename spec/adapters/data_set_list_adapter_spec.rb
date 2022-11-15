describe DataSetListAdapter do
  let(:analysis) { create :analysis, :with_realistic_attributes, element_id: 1 }
  let(:data_set_list_adapter) { described_class.new analysis }

  describe ".new" do
    subject { data_set_list_adapter }

    it { is_expected.to be_a described_class }
  end
end
