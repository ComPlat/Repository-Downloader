describe Reaction do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Reaction" }

  describe "factories" do
    describe "without trait" do
      subject(:factory) { build :reaction }

      it { is_expected.to be_valid }
      it { expect(factory.save).to be true }
    end

    describe "with trait :with_realistic_attributes" do
      subject(:factory) { build :reaction, :with_realistic_attributes }

      it { is_expected.to be_valid }
      it { expect(factory.save).to be true }
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:samples).with_foreign_key(:ancestry).inverse_of(:reaction).dependent(:restrict_with_exception) }

    describe "#samples" do
      subject(:samples) { reaction.samples }

      let(:reaction) { create :reaction }
      let(:sample) { create :sample, reaction: }

      it { is_expected.to eq [sample] }
      it { is_expected.to eq [] }
    end
  end

  describe "#chemotion_id" do
    subject(:chemotion_id) { reaction.chemotion_id }

    let(:reaction) { create :reaction, :with_realistic_attributes, id: 1 }

    it { is_expected.to eq "CRR-#{reaction.id}" }
    it { is_expected.to eq "CRR-1" }
  end

  describe "#present_to_api" do
    subject(:present_to_api) { reaction.present_to_api }

    let(:reaction) { create :reaction, :with_realistic_attributes }
    let(:reaction_to_reaction_mapper_adapter) { RootAdapters::ReactionToReactionMapperAdapter.new reaction }
    let(:reaction_to_reaction_mapper_adapter_hash) { reaction_to_reaction_mapper_adapter.to_h }
    let(:reaction_mapper) { RootMappers::ReactionMapper.from_hash reaction_to_reaction_mapper_adapter_hash }

    it { expect(present_to_api).to be_a RootMappers::ReactionMapper }
    it { expect(present_to_api.identifier).to eq reaction.chemotion_id }
    it { expect(present_to_api.context).to eq reaction_to_reaction_mapper_adapter.context }
    it { expect(present_to_api.to_json).to eq reaction_mapper.to_json }
    it { expect(present_to_api.to_xml).to eq reaction_mapper.to_xml }
    it { expect(present_to_api.to_csv).to eq reaction_mapper.to_csv }
  end

  describe "#doi" do
    subject(:doi) { reaction.doi }

    let(:reaction) { create :reaction, :with_realistic_attributes }

    it { is_expected.to eq "10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ" }
  end

  describe "#temperature_user_text" do
    subject(:temperature_user_text) { reaction.temperature_user_text }

    let(:reaction) { create :reaction, :with_realistic_attributes }

    it { is_expected.to eq "118" }
  end

  describe "#temperature_value_unit" do
    subject(:temperature_value_unit) { reaction.temperature_value_unit }

    let(:reaction) { create :reaction, :with_realistic_attributes, id: 1 }

    it { is_expected.to eq "°C" }
  end
end
