describe Reaction do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Reaction" }
  it { expect { create :reaction }.to change(described_class, :count).from(0).to(1) }
  it { expect(create(:reaction)).to be_valid }
  it { expect(create(:reaction)).to be_persisted }

  describe "#chemotion_id" do
    subject(:chemotion_id) { reaction.chemotion_id }

    let(:reaction) { create :reaction, :with_realistic_attributes }

    it { is_expected.to eq "CRR-#{reaction.id}" }
  end

  describe "#present_to_api" do
    subject(:present_to_api) { reaction.present_to_api }

    let(:reaction) { create :reaction, :with_realistic_attributes }
    let(:reaction_to_reaction_mapper_adapter) { ReactionToReactionMapperAdapter.new reaction }
    let(:reaction_to_reaction_mapper_adapter_hash) { reaction_to_reaction_mapper_adapter.to_h }
    let(:reaction_mapper) { RootMappers::ReactionMapper.from_hash reaction_to_reaction_mapper_adapter_hash }

    it { expect(present_to_api).to be_a RootMappers::ReactionMapper }
    it { expect(present_to_api.identifier).to eq reaction.chemotion_id }
    it { expect(present_to_api.context).to eq reaction_to_reaction_mapper_adapter.context }
    it { expect(present_to_api.to_json).to eq reaction_mapper.to_json }
    it { expect(present_to_api.to_xml).to eq reaction_mapper.to_xml }
    it { expect(present_to_api.to_csv).to eq reaction_mapper.to_csv }
  end
end
