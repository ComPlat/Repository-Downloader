describe RootAdapters::SampleToSampleMapperAdapter do
  let(:sample) { create :sample, :with_required_dependencies, :with_realistic_attributes }
  let(:sample_to_sample_mapper_adapter) { described_class.new sample }

  describe ".new" do
    subject { sample_to_sample_mapper_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { sample_to_sample_mapper_adapter.to_h }

    let(:expected_hash) do
      {context: sample_to_sample_mapper_adapter.context,
       type: sample_to_sample_mapper_adapter.type,
       dct_conformsTo: sample_to_sample_mapper_adapter.dct_conformsTo,
       id: sample_to_sample_mapper_adapter.id,
       name: sample_to_sample_mapper_adapter.name,
       url: sample_to_sample_mapper_adapter.url,
       identifier: sample_to_sample_mapper_adapter.identifier,
       iupacName: sample_to_sample_mapper_adapter.iupacName,
       smiles: sample_to_sample_mapper_adapter.smiles,
       inChI: sample_to_sample_mapper_adapter.inChI,
       inChIKey: sample_to_sample_mapper_adapter.inChIKey,
       molecularFormula: sample_to_sample_mapper_adapter.molecularFormula,
       meltingPoint: sample_to_sample_mapper_adapter.meltingPoint,
       boilingPoint: sample_to_sample_mapper_adapter.boilingPoint,
       molecularWeight: sample_to_sample_mapper_adapter.molecularWeight,
       analysisList: sample_to_sample_mapper_adapter.analysisList}
    end

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

    it { is_expected.to eq SampleAdapter::DctConformsAdapter.new.to_h }
  end

  describe "#id" do
    subject { sample_to_sample_mapper_adapter.id }

    it { is_expected.to eq sample.doi }
  end

  describe "#name" do
    subject { sample_to_sample_mapper_adapter.name }

    it { is_expected.to eq sample.iupac_name }
  end

  describe "#url" do
    subject { sample_to_sample_mapper_adapter.url }

    it { is_expected.to eq "https://dx.doi.org/#{sample_to_sample_mapper_adapter.id}" }
  end

  describe "#identifier" do
    subject { sample_to_sample_mapper_adapter.identifier }

    it { is_expected.to eq sample.chemotion_id }
  end

  describe "#iupacName" do
    subject { sample_to_sample_mapper_adapter.iupacName }

    it { is_expected.to eq sample_to_sample_mapper_adapter.name }
  end

  describe "#smiles" do
    subject { sample_to_sample_mapper_adapter.smiles }

    it { is_expected.to eq sample.cano_smiles }
  end

  describe "#inChI" do
    subject { sample_to_sample_mapper_adapter.inChI }

    it { is_expected.to eq sample.inchistring }
  end

  describe "#inChIKey" do
    subject { sample_to_sample_mapper_adapter.inChIKey }

    it { is_expected.to eq sample.inchikey }
  end

  describe "#molecularFormula" do
    subject { sample_to_sample_mapper_adapter.molecularFormula }

    it { is_expected.to eq sample.sum_formular }
  end

  describe "#meltingPoint" do
    subject { sample_to_sample_mapper_adapter.meltingPoint }

    context "when called with no parameters" do
      let(:infinity_range) { -Float::INFINITY...Float::INFINITY }

      it { is_expected.to eq(infinity_range.to_s) }
    end

    context "when called with room temperature" do
      let(:sample) { create :sample, :with_required_dependencies, :with_realistic_attributes, sample_melting_point: room_temperature }
      let(:room_temperature) { 18.0...25.0 }

      it { is_expected.to eq room_temperature.to_s }
    end
  end

  describe "#boilingPoint" do
    subject { sample_to_sample_mapper_adapter.boilingPoint }

    context "when called with no parameters" do
      let(:infinity_range) { -Float::INFINITY...Float::INFINITY }

      it { is_expected.to eq(infinity_range.to_s) }
    end

    context "when called with room temperature" do
      let(:sample) { create :sample, :with_required_dependencies, :with_realistic_attributes, sample_boiling_point: room_temperature }
      let(:room_temperature) { 18.0...25.0 }

      it { is_expected.to eq room_temperature.to_s }
    end
  end

  describe "#molecularWeight" do
    subject { sample_to_sample_mapper_adapter.molecularWeight }

    it { is_expected.to eq SampleAdapter::MolecularWeightAdapter.new(sample).to_h }
  end

  describe "#analysisList" do
    subject { sample_to_sample_mapper_adapter.analysisList }

    it { is_expected.to eq SampleAdapter::AnalysisListAdapter.new(sample).to_h }
  end
end
