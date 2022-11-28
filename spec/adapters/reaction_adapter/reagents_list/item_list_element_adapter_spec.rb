describe ReactionAdapter::ReagentsList::ItemListElementAdapter do
  let(:sample) { create :sample, :with_required_dependencies, :with_realistic_attributes }
  let(:item_list_element_adapter) { described_class.new sample }

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

    it { is_expected.to eq "http://purl.org/dc/terms/conformsTo" => SampleAdapter::DctElementAdapter.new.to_h }
  end

  describe "#id" do
    subject { item_list_element_adapter.id }

    it { is_expected.to eq "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1" }
  end

  describe "#identifier" do
    subject { item_list_element_adapter.identifier }

    it { is_expected.to eq sample.chemotion_id }
  end

  describe "#name" do
    subject { item_list_element_adapter.name }

    it { is_expected.to eq "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine" }
  end

  describe "#molecularFormula" do
    subject { item_list_element_adapter.molecularFormula }

    it { is_expected.to eq "C20H14N8" }
  end

  describe "#inChIKey" do
    subject { item_list_element_adapter.inChIKey }

    it { is_expected.to eq "MUAMZYSBUQADBN-UHFFFAOYSA-N" }
  end

  describe "#smiles" do
    subject { item_list_element_adapter.smiles }

    it { is_expected.to eq "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1" }
  end
end
