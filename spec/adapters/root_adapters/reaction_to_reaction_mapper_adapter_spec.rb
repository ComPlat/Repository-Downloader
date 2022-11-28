describe RootAdapters::ReactionToReactionMapperAdapter do
  let(:reaction) { sample.reaction }
  let(:sample) { build :sample, :with_realistic_attributes, :with_required_dependencies }
  let(:reaction_to_reaction_mapper_adapter) { described_class.new reaction }

  describe ".new" do
    subject { reaction_to_reaction_mapper_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { reaction_to_reaction_mapper_adapter.to_h }

    let(:expected_hash) {
      {context: reaction_to_reaction_mapper_adapter.context,
       id: reaction_to_reaction_mapper_adapter.id,
       type: reaction_to_reaction_mapper_adapter.type,
       name: reaction_to_reaction_mapper_adapter.name,
       identifier: reaction_to_reaction_mapper_adapter.identifier,
       status: reaction_to_reaction_mapper_adapter.status,
       description: reaction_to_reaction_mapper_adapter.description,
       temperature: reaction_to_reaction_mapper_adapter.temperature,
       reaction_type: reaction_to_reaction_mapper_adapter.reaction_type,
       duration: reaction_to_reaction_mapper_adapter.duration,
       purification: reaction_to_reaction_mapper_adapter.purification,
       reagents_list: reaction_to_reaction_mapper_adapter.reagents_list}
    }

    it { is_expected.to eq expected_hash }
  end

  describe "#context" do
    subject { reaction_to_reaction_mapper_adapter.context }

    it { is_expected.to eq "https://schema.org/" }
  end

  describe "#id" do
    subject { reaction_to_reaction_mapper_adapter.id }

    it { is_expected.to eq reaction.doi }
  end

  describe "#type" do
    subject { reaction_to_reaction_mapper_adapter.type }

    it { is_expected.to eq "BioChemicalReaction" }
  end

  describe "#name" do
    subject { reaction_to_reaction_mapper_adapter.name }

    it { is_expected.to eq "" }
  end

  describe "#identifier" do
    subject { reaction_to_reaction_mapper_adapter.identifier }

    it { is_expected.to eq reaction.chemotion_id }
  end

  describe "#status" do
    subject { reaction_to_reaction_mapper_adapter.status }

    it { is_expected.to eq reaction.reaction_status.to_s }
  end

  describe "#description" do
    subject { reaction_to_reaction_mapper_adapter.description }

    it { is_expected.to eq reaction.reaction_description.to_s }
  end

  describe "#temperature" do
    subject { reaction_to_reaction_mapper_adapter.temperature }

    it { is_expected.to eq "#{reaction.temperature_user_text} #{reaction.temperature_value_unit}" }
  end

  describe "#reaction_type" do
    subject { reaction_to_reaction_mapper_adapter.reaction_type }

    it { is_expected.to eq reaction.rxno.to_s }
  end

  describe "#duration" do
    subject { reaction_to_reaction_mapper_adapter.duration }

    it { is_expected.to eq reaction.reaction_duration.to_s }
  end

  describe "#purification" do
    subject { reaction_to_reaction_mapper_adapter.purification }

    context "when called with one parameter" do
      let(:expected_reaction_purification) { (reaction.reaction_purification || []).join(",") }

      it { is_expected.to eq expected_reaction_purification }
    end

    context "when called with two parameters" do
      let(:reaction_purification) { ["Flash-Chromatography", "HPLC"] }
      let(:reaction) { build :reaction, :with_realistic_attributes, reaction_purification: reaction_purification }

      let(:expected_reaction_purification) { "Flash-Chromatography, HPLC" }

      it { is_expected.to eq expected_reaction_purification }
    end
  end

  describe "#reagents_list" do
    subject { reaction_to_reaction_mapper_adapter.reagents_list }

    it { is_expected.to eq ReactionAdapter::ReagentsListAdapter.new(reaction).to_h }
  end
end
