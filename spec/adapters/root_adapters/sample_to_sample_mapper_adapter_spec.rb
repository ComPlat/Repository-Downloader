describe RootAdapters::SampleToSampleMapperAdapter do
  let(:sample) { create :sample, :with_required_dependencies, :with_realistic_attributes }
  let(:sample_to_sample_mapper_adapter) { described_class.new sample }

  describe ".new" do
    subject { sample_to_sample_mapper_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { sample_to_sample_mapper_adapter.to_h }

    let(:expected_hash) {
      {context: "https://schema.org/",
       type: "MolecularEntity",
       dct_conformsTo: {"http://purl.org/dc/terms/conformsTo" => SampleAdapter::DctElementAdapter.new.to_h},
       id: "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
       name: "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
       url: "https://dx.doi.org/10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
       identifier: "CRS-4558",
       iupacName: "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
       smiles: "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1",
       inChI: "InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)",
       inChIKey: "MUAMZYSBUQADBN-UHFFFAOYSA-N",
       molecularFormula: "C20H14N8",
       meltingPoint: "-Infinity...Infinity",
       boilingPoint: "-Infinity...Infinity",
       molecularWeight: {"value" => 366.37876000000006},
       analysisList: {itemListElement: [], numberOfItems: 0}}
    }

    it { is_expected.to eq expected_hash }
  end

  describe "#context" do
    subject { sample_to_sample_mapper_adapter.context }

    it { is_expected.to eq "https://schema.org/" }
  end

  describe "#type" do
    subject { sample_to_sample_mapper_adapter.type }

    it { is_expected.to eq "MolecularEntity" }
  end

  describe "#dct_conformsTo" do
    subject { sample_to_sample_mapper_adapter.dct_conformsTo }

    it { is_expected.to eq "http://purl.org/dc/terms/conformsTo" => SampleAdapter::DctElementAdapter.new.to_h }
  end

  describe "#id" do
    subject { sample_to_sample_mapper_adapter.id }

    it { is_expected.to eq "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1" }
  end

  describe "#name" do
    subject { sample_to_sample_mapper_adapter.name }

    it { is_expected.to eq "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine" }
  end

  describe "#url" do
    subject { sample_to_sample_mapper_adapter.url }

    it { is_expected.to eq "https://dx.doi.org/10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1" }
  end

  describe "#identifier" do
    subject { sample_to_sample_mapper_adapter.identifier }

    it { is_expected.to eq "CRS-4558" }
  end

  describe "#iupacName" do
    subject { sample_to_sample_mapper_adapter.iupacName }

    it { is_expected.to eq "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine" }
  end

  describe "#smiles" do
    subject { sample_to_sample_mapper_adapter.smiles }

    it { is_expected.to eq "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1" }
  end

  describe "#inChI" do
    subject { sample_to_sample_mapper_adapter.inChI }

    it { is_expected.to eq "InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)" }
  end

  describe "#inChIKey" do
    subject { sample_to_sample_mapper_adapter.inChIKey }

    it { is_expected.to eq "MUAMZYSBUQADBN-UHFFFAOYSA-N" }
  end

  describe "#molecularFormula" do
    subject { sample_to_sample_mapper_adapter.molecularFormula }

    it { is_expected.to eq "C20H14N8" }
  end

  describe "#meltingPoint" do
    subject { sample_to_sample_mapper_adapter.meltingPoint }

    it { is_expected.to eq "-Infinity...Infinity" }
  end

  describe "#boilingPoint" do
    subject { sample_to_sample_mapper_adapter.boilingPoint }

    it { is_expected.to eq "-Infinity...Infinity" }
  end

  describe "#molecularWeight" do
    subject { sample_to_sample_mapper_adapter.molecularWeight }

    it { is_expected.to eq({"value" => 366.37876000000006}) }
  end

  describe "#analysisList" do
    subject { sample_to_sample_mapper_adapter.analysisList }

    it { is_expected.to eq({itemListElement: [], numberOfItems: 0}) }
  end
end
