describe SampleToSampleMapperAdapter do
  let(:sample) { create :sample, :with_realistic_attributes }
  let(:sample_to_sample_mapper_adapter) { described_class.new sample }

  describe ".new" do
    subject { sample_to_sample_mapper_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { sample_to_sample_mapper_adapter.to_h }

    let(:expected_hash) {
      {context: "https://schema.org/",
       type: "",
       dct_conformsTo: {},
       id: "",
       name: "",
       url: "",
       identifier: "CRS-4558",
       iupacName: "",
       smiles: "",
       inChI: "",
       inChIKey: "",
       molecularFormula: "",
       meltingPoint: "",
       boilingPoint: "",
       molecularWeight: "",
       analysisList: ""}
    }

    it { is_expected.to eq expected_hash }
  end

  describe "#context" do
    subject { sample_to_sample_mapper_adapter.context }

    it { is_expected.to eq "https://schema.org/" }
  end

  describe "#type" do
    subject { sample_to_sample_mapper_adapter.type }

    it { is_expected.to eq "" }
  end

  describe "#dct_conformsTo" do
    subject { sample_to_sample_mapper_adapter.dct_conformsTo }

    it { is_expected.to eq({}) }
  end

  describe "#id" do
    subject { sample_to_sample_mapper_adapter.id }

    it { is_expected.to eq "" }
  end

  describe "#name" do
    subject { sample_to_sample_mapper_adapter.name }

    it { is_expected.to eq "" }
  end

  describe "#url" do
    subject { sample_to_sample_mapper_adapter.url }

    it { is_expected.to eq "" }
  end

  describe "#identifier" do
    subject { sample_to_sample_mapper_adapter.identifier }

    it { is_expected.to eq "CRS-4558" }
  end

  describe "#iupacName" do
    subject { sample_to_sample_mapper_adapter.iupacName }

    it { is_expected.to eq "" }
  end

  describe "#smiles" do
    subject { sample_to_sample_mapper_adapter.smiles }

    it { is_expected.to eq "" }
  end

  describe "#inChI" do
    subject { sample_to_sample_mapper_adapter.inChI }

    it { is_expected.to eq "" }
  end

  describe "#inChIKey" do
    subject { sample_to_sample_mapper_adapter.inChIKey }

    it { is_expected.to eq "" }
  end

  describe "#molecularFormula" do
    subject { sample_to_sample_mapper_adapter.molecularFormula }

    it { is_expected.to eq "" }
  end

  describe "#meltingPoint" do
    subject { sample_to_sample_mapper_adapter.meltingPoint }

    it { is_expected.to eq "" }
  end

  describe "#boilingPoint" do
    subject { sample_to_sample_mapper_adapter.boilingPoint }

    it { is_expected.to eq "" }
  end

  describe "#molecularWeight" do
    subject { sample_to_sample_mapper_adapter.molecularWeight }

    it { is_expected.to eq "" }
  end

  describe "#analysisList" do
    subject { sample_to_sample_mapper_adapter.analysisList }

    it { is_expected.to eq "" }
  end
end
