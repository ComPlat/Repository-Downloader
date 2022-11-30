describe ReactionAdapter::ReagentsList::ItemListElementAdapter do
  let(:sample) { create :sample, :with_required_dependencies, :with_realistic_attributes }
  let(:item_list_element_adapter) { described_class.new sample }
  let(:sample_to_sample_adapter) { RootAdapters::SampleToSampleMapperAdapter.new sample }

  describe ".new" do
    subject { item_list_element_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { item_list_element_adapter.to_h }

    let(:expected_hash) do
      {type: item_list_element_adapter.type,
       dct_conformsTo: item_list_element_adapter.dct_conformsTo,
       id: item_list_element_adapter.id,
       identifier: item_list_element_adapter.identifier,
       name: item_list_element_adapter.name,
       molecularFormula: item_list_element_adapter.molecularFormula,
       inChIKey: item_list_element_adapter.inChIKey,
       smiles: item_list_element_adapter.smiles}
    end

    it { is_expected.to eq expected_hash }
  end

  describe "#type" do
    subject { item_list_element_adapter.type }

    it { is_expected.to eq "MolecularEntity" }
  end

  describe "#dct_conformsTo" do
    subject { item_list_element_adapter.dct_conformsTo }

    let(:expected_hash) { {type: "CreativeWork", id: "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/"} }

    it { is_expected.to eq expected_hash }
  end

  describe "#id" do
    subject { item_list_element_adapter.id }

    it { is_expected.to eq sample_to_sample_adapter.id }
  end

  describe "#identifier" do
    subject { item_list_element_adapter.identifier }

    it { is_expected.to eq sample_to_sample_adapter.identifier }
  end

  describe "#name" do
    subject { item_list_element_adapter.name }

    it { is_expected.to eq sample_to_sample_adapter.name }
  end

  describe "#molecularFormula" do
    subject { item_list_element_adapter.molecularFormula }

    it { is_expected.to eq sample_to_sample_adapter.molecularFormula }
  end

  describe "#inChIKey" do
    subject { item_list_element_adapter.inChIKey }

    it { is_expected.to eq sample_to_sample_adapter.inChIKey }
  end

  describe "#smiles" do
    subject { item_list_element_adapter.smiles }

    it { is_expected.to eq sample_to_sample_adapter.smiles }
  end
end
