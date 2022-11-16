describe ReactionToReactionMapperAdapter do
  let(:reaction) { build :reaction, :with_realistic_attributes }
  let(:reaction_to_reaction_mapper_adapter) { described_class.new reaction }

  describe ".new" do
    subject { reaction_to_reaction_mapper_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { reaction_to_reaction_mapper_adapter.to_h }

    let(:expected_hash) {
      {context: "https://schema.org/",
       id: "",
       type: "",
       name: "",
       identifier: "CRR-9739",
       status: "",
       description: "",
       temperature: "",
       reaction_type: "",
       duration: "",
       purification: "",
       reagents_list: {}}
    }

    it { is_expected.to eq expected_hash }
  end

  describe "#context" do
    subject { reaction_to_reaction_mapper_adapter.context }

    it { is_expected.to eq "https://schema.org/" }
  end

  describe "#identifier" do
    subject { reaction_to_reaction_mapper_adapter.identifier }

    it { is_expected.to eq reaction.chemotion_id }
  end
end
