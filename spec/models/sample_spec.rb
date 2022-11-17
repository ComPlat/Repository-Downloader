describe Sample do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Sample" }
  it { expect { create :sample }.to change(described_class, :count).from(0).to(1) }
  it { expect(create(:sample)).to be_valid }
  it { expect(create(:sample)).to be_persisted }

  describe "#chemotion_id" do
    subject(:chemotion_id) { sample.chemotion_id }

    let(:sample) { create :sample, :with_realistic_attributes }

    it { is_expected.to eq "CRS-#{sample.id}" }
  end

  describe "#present_to_api" do
    subject(:present_to_api) { sample.present_to_api }

    let(:sample) { create :sample }
    let(:sample_to_sample_mapper_adapter) { SampleToSampleMapperAdapter.new sample }
    let(:sample_to_sample_mapper_adapter_hash) { sample_to_sample_mapper_adapter.to_h }
    let(:sample_mapper) { SampleMapper.from_hash sample_to_sample_mapper_adapter_hash }

    it { expect(present_to_api).to be_a SampleMapper }
    it { expect(present_to_api.identifier).to eq sample.chemotion_id }
    it { expect(present_to_api.context).to eq sample_to_sample_mapper_adapter.context }
    it { expect(present_to_api.to_json).to eq sample_mapper.to_json }
    it { expect(present_to_api.to_xml).to eq sample_mapper.to_xml }
    it { expect(present_to_api.to_csv).to eq sample_mapper.to_csv }
  end
end
