describe RootAdapters::ReactionToReactionMapperAdapter do
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
       id: "10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ",
       type: "BioChemicalReaction",
       name: "",
       identifier: "CRR-9739",
       status: "Successful",
       description: "--- !ruby/hash:Hashie::Mashops:
- !ruby/hash:Hashie::Mash
  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine
    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic
    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water
    were added. The precipitate was filtered off and washed with water. The crude
    product was recrystallized from ethanol to give 106 g of a colorless solid.

'
",
       temperature: "118 °C",
       reaction_type: "MOP:0000790 | substitution reaction",
       duration: "4 Hour(s)",
       purification: "Crystallisation",
       reagents_list: {}}
    }

    it { is_expected.to eq expected_hash }
  end

  describe "#context" do
    subject { reaction_to_reaction_mapper_adapter.context }

    it { is_expected.to eq "https://schema.org/" }
  end

  describe "#id" do
    subject { reaction_to_reaction_mapper_adapter.id }

    it { is_expected.to eq "10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ" }
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

    it { is_expected.to eq "Successful" }
  end

  describe "#description" do
    subject { reaction_to_reaction_mapper_adapter.description }

    let(:expected_string) do
      "--- !ruby/hash:Hashie::Mashops:
- !ruby/hash:Hashie::Mash
  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine
    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic
    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water
    were added. The precipitate was filtered off and washed with water. The crude
    product was recrystallized from ethanol to give 106 g of a colorless solid.

'
"
    end

    it { is_expected.to eq expected_string }
  end

  describe "#temperature" do
    subject { reaction_to_reaction_mapper_adapter.temperature }

    it { is_expected.to eq "118 °C" }
  end

  describe "#reaction_type" do
    subject { reaction_to_reaction_mapper_adapter.reaction_type }

    it { is_expected.to eq "MOP:0000790 | substitution reaction" }
  end

  describe "#duration" do
    subject { reaction_to_reaction_mapper_adapter.duration }

    it { is_expected.to eq "4 Hour(s)" }
  end

  describe "#purification" do
    subject { reaction_to_reaction_mapper_adapter.purification }

    it { is_expected.to eq "Crystallisation" }
  end

  describe "#reagents_list" do
    subject { reaction_to_reaction_mapper_adapter.reagents_list }

    it { is_expected.to eq({}) }
  end
end
