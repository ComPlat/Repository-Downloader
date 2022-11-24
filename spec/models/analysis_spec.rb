describe Analysis do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Container" }
  it { expect { create :analysis }.to change(described_class, :count).from(0).to(1) }
  it { expect(create(:analysis)).to be_valid }
  it { expect(create(:analysis)).to be_persisted }

  describe "associations" do
    it { is_expected.to have_many(:attachments).with_primary_key(:element_id).with_foreign_key(:ana_id).inverse_of(:analysis).dependent(:restrict_with_exception) }
  end

  describe "#attachments" do
    subject { analysis.attachments }

    let(:analysis) { create :analysis, element_id: 1 }
    let(:attachments) { create_list :attachment, 1, id: 2, ana_id: analysis.element_id }

    it { is_expected.to eq attachments }
  end

  describe "#chemotion_id" do
    subject(:chemotion_id) { analysis.chemotion_id }

    let(:analysis) { create :analysis, :with_realistic_attributes }

    it { is_expected.to eq "CRD-#{analysis.id}" }
  end

  describe "#present_to_api" do
    subject(:present_to_api) { analysis.present_to_api }

    let(:analysis) { create :analysis, :with_realistic_attributes }
    let(:analysis_to_analysis_mapper_adapter) { RootAdapters::AnalysisToAnalysisMapperAdapter.new analysis }
    let(:analysis_to_analysis_mapper_adapter_hash) { analysis_to_analysis_mapper_adapter.to_h }
    let(:analysis_mapper) { RootMappers::AnalysisMapper.from_hash analysis_to_analysis_mapper_adapter_hash }

    it { expect(present_to_api).to be_a RootMappers::AnalysisMapper }
    it { expect(present_to_api.identifier).to eq analysis.chemotion_id }
    it { expect(present_to_api.context).to eq analysis_to_analysis_mapper_adapter.context }
    it { expect(present_to_api.to_json).to eq analysis_mapper.to_json }
    it { expect(present_to_api.to_xml).to eq analysis_mapper.to_xml }
    it { expect(present_to_api.to_csv).to eq analysis_mapper.to_csv }
  end

  describe "#doi" do
    subject { analysis.doi }

    let(:analysis) { create :analysis, :with_realistic_attributes }

    it { is_expected.to eq "10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1" }
  end

  describe "#kind" do
    subject { analysis.kind }

    let(:analysis) { create :analysis, :with_realistic_attributes }

    it { is_expected.to eq "CHMO:0000595 | 13C nuclear magnetic resonance spectroscopy (13C NMR)" }
  end
end
