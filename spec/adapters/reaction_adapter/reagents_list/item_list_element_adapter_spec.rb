describe ReactionAdapter::ReagentsList::ItemListElementAdapter do
  let(:sample) { build :sample, :with_required_dependencies, :with_realistic_attributes }
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
    it { is_expected.to be_a String }
  end

  describe "#dct_conformsTo" do
    subject { item_list_element_adapter.dct_conformsTo }

    it { is_expected.to eq SampleAdapter::DctConformsToElementAdapter.new.to_h }
  end

  describe "#id" do
    subject { item_list_element_adapter.id }

    it { is_expected.to eq sample_to_sample_adapter.id }
    it { is_expected.to be_a String }
  end

  describe "#identifier" do
    subject { item_list_element_adapter.identifier }

    it { is_expected.to eq sample_to_sample_adapter.identifier }
    it { is_expected.to be_a String }
  end

  describe "#name" do
    subject { item_list_element_adapter.name }

    it { is_expected.to eq sample_to_sample_adapter.name }
    it { is_expected.to be_a String }
  end

  describe "#molecularFormula" do
    subject { item_list_element_adapter.molecularFormula }

    it { is_expected.to eq sample_to_sample_adapter.molecularFormula }
    it { is_expected.to be_a String }
  end

  describe "#inChIKey" do
    subject { item_list_element_adapter.inChIKey }

    it { is_expected.to eq sample_to_sample_adapter.inChIKey }
    it { is_expected.to be_a String }
  end

  describe "#smiles" do
    subject { item_list_element_adapter.smiles }

    it { is_expected.to eq sample_to_sample_adapter.smiles }
    it { is_expected.to be_a String }
  end
end
