describe ReactionAdapter::ReagentsListAdapter do
  let(:sample) { build :sample, :with_realistic_attributes }
  let(:reaction) { build :reaction, :with_realistic_attributes, samples: [sample] }
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

    it { is_expected.to eq reaction.samples.size }
  end

  describe "#itemListElement" do
    subject { reagents_list_adapter.itemListElement }

    it { is_expected.to eq ReactionAdapter::ReagentsList::ItemListElementAdapterIterator.new([sample]).to_a }
  end
end
