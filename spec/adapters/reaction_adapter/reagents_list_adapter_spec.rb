describe ReactionAdapter::ReagentsListAdapter do
  let(:reaction) { build :reaction, :with_realistic_attributes }
  let(:reagents_list_adapter) { described_class.new reaction }

  describe ".new" do
    subject { reagents_list_adapter }

    it { is_expected.to be_a described_class }
  end
end
