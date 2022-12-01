describe ReactionAdapter::ReagentsList::ItemListElementAdapterIterator do
  let(:sample) { build :sample, :with_realistic_attributes, :with_required_dependencies }
  let(:item_list_element_adapter_iterator) { described_class.new sample.reaction }

  describe ".new" do
    subject { item_list_element_adapter_iterator }

    it { is_expected.to be_a described_class }
  end

  describe "#to_a" do
    subject { item_list_element_adapter_iterator.to_a }

    let(:item_list_element_adapter) { ReactionAdapter::ReagentsList::ItemListElementAdapter.new sample }

    let(:expected_array) do
      [type: item_list_element_adapter.type,
       dct_conformsTo: item_list_element_adapter.dct_conformsTo,
       id: item_list_element_adapter.id,
       identifier: item_list_element_adapter.identifier,
       name: item_list_element_adapter.name,
       molecularFormula: item_list_element_adapter.molecularFormula,
       inChIKey: item_list_element_adapter.inChIKey,
       smiles: item_list_element_adapter.smiles]
    end

    it { is_expected.to eq expected_array }
  end
end
