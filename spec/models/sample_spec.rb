describe Sample do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Sample" }
  it { expect { create :sample }.to change(described_class, :count).from(0).to(1) }
  it { expect(create(:sample)).to be_valid }
  it { expect(create(:sample)).to be_persisted }

  describe "#analyses" do
    subject(:analyses) { sample.analyses }

    context "when taggable_data is nil" do
      let(:sample) { create :sample, taggable_data: nil }

      it { is_expected.to eq [] }
    end

    context "when taggable_data is a Hash and has nil on key original_analysis_ids" do
      let(:sample) { create :sample, taggable_data: {"original_analysis_ids" => nil} }

      it { is_expected.to eq [] }
    end

    context "when taggable_data is a Hash and has an empty Array on key original_analysis_ids" do
      let(:sample) { create :sample, taggable_data: {"original_analysis_ids" => []} }

      it { is_expected.to eq [] }
    end

    context "when taggable_data is a Hash and has an Array on key original_analysis_ids with an id that no Analysis has" do
      let(:sample) { create :sample, taggable_data: {"original_analysis_ids" => [0]} }

      it { is_expected.to eq [] }
    end

    context "when taggable_data is a Hash and has an Array on key original_analysis_ids with id of an analysis in it" do
      let(:sample) { create :sample, taggable_data: {"original_analysis_ids" => [analysis.id]} }
      let(:analysis) { create :analysis, id: 1 }

      it { is_expected.to eq [analysis] }
    end
  end

  describe "#chemotion_id" do
    subject(:chemotion_id) { sample.chemotion_id }

    let(:sample) { create :sample, :with_realistic_attributes }

    it { is_expected.to eq "CRS-#{sample.id}" }
  end

  describe "#present_to_api" do
    subject(:present_to_api) { sample.present_to_api }

    let(:sample) { create :sample, :with_realistic_attributes }
    let(:sample_to_sample_mapper_adapter) { RootAdapters::SampleToSampleMapperAdapter.new sample }
    let(:sample_to_sample_mapper_adapter_hash) { sample_to_sample_mapper_adapter.to_h }
    let(:sample_mapper) { RootMappers::SampleMapper.from_hash sample_to_sample_mapper_adapter_hash }

    it { is_expected.to be_a RootMappers::SampleMapper }
    it { expect(present_to_api.identifier).to eq sample.chemotion_id }
    it { expect(present_to_api.context).to eq sample_to_sample_mapper_adapter.context }
    it { expect(present_to_api.to_json).to eq sample_mapper.to_json }
    it { expect(present_to_api.to_xml).to eq sample_mapper.to_xml }
    it { expect(present_to_api.to_csv).to eq sample_mapper.to_csv }
  end
end
