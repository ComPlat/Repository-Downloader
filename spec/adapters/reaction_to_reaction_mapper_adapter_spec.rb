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
      {context: "",
       id: "",
       type: "",
       name: "",
       identifier: "",
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
end
