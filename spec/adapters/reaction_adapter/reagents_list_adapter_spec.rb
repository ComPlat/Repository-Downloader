describe ReactionAdapter::ReagentsListAdapter do
  let(:reaction) { sample.reaction }
  let(:sample) { create :sample, :with_realistic_attributes, :with_required_dependencies }
  let(:reagents_list_adapter) { described_class.new reaction }

  describe ".new" do
    subject { reagents_list_adapter }

    it { is_expected.to be_a described_class }
  end

  describe ".to_h" do
    subject { reagents_list_adapter.to_h }

    let(:expected_hash) do
      {
        numberOfItems: reagents_list_adapter.numberOfItems,
        itemListElement: reagents_list_adapter.itemListElement
      }
    end

    it { is_expected.to eq expected_hash }
  end

  describe "#numberOfItems" do
    subject { reagents_list_adapter.numberOfItems }

    it { is_expected.to eq reaction.samples.count }
  end

  describe "#itemListElement" do
    subject { reagents_list_adapter.itemListElement }

    it { is_expected.to eq ReactionAdapter::ReagentsList::ItemListElementAdapterIterator.new(reaction).to_a }
  end
end
