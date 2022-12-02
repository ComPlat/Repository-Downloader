describe Analysis do
  let(:analysis) { build :analysis, :with_realistic_attributes }

  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Container" }

  describe "factories" do
    describe "with traits :with_realistic_attributes" do
      subject(:factory) { build :analysis, :with_realistic_attributes }

      it { is_expected.to be_valid }
      it { expect(factory.element_id).to be_a Integer } # HINT: Needed because without element_id belongs_to attachment does not work
      it { expect(factory.save).to be true }
    end

    describe "without trait" do
      subject(:factory) { build :analysis }

      it { is_expected.to be_valid }
      it { expect(factory.element_id).to be_a Integer }
      it { expect(factory.save).to be true }
    end
  end

  describe "associations" do
    it { is_expected.to have_many(:attachments).with_primary_key(:element_id).with_foreign_key(:ana_id).inverse_of(:analysis).dependent(:restrict_with_exception) }

    describe "#attachments" do
      subject { analysis.attachments }

      let(:analysis) { create :analysis }
      let(:attachment) { create :attachment, analysis: }

      it { is_expected.to eq [attachment] }
      it { is_expected.to eq [] }
    end
  end

  describe ".new" do
    let(:analysis) { create :analysis, :with_realistic_attributes }

    it { expect(analysis).to be_a described_class }
  end

  describe "#chemotion_id" do
    subject(:chemotion_id) { analysis.chemotion_id }

    let(:analysis) { build :analysis, id: }

    context "when id is 1" do
      let(:id) { 1 }

      it { is_expected.to eq "CRD-1" }
    end
  end

  describe "#content" do
    subject(:content) { analysis.content }

    context "when content is a stringified JSON" do
      let(:json) { JSON.parse(analysis.extended_metadata&.dig("content")) }

      it { is_expected.to eq json }
      it { is_expected.to eq({"ops" => [{"insert" => " "}, {"attributes" => {"script" => "super"}, "insert" => "13"}, {"insert" => "C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]}) }
    end

    context "when content is nil" do
      let(:analysis) { build :analysis }

      it { is_expected.to eq({}) }
    end
  end

  describe "#doi_url" do
    subject(:doi_uri) { analysis.doi_uri }

    context "when doi is nil" do
      let(:analysis) { build :analysis, :with_realistic_attributes, taggable_data: nil }

      it { is_expected.to eq "" }
      it { is_expected.to be_a String }
    end

    context "when doi exists" do
      let(:expected_id) { "https://dx.doi.org/#{analysis.doi}" }

      it { is_expected.to eq expected_id }
      it { is_expected.to be_a String }
    end
  end

  describe "#doi" do
    subject(:doi) { analysis.doi }

    context "when taggable_data is correctly filled" do
      it { is_expected.to eq analysis.taggable_data&.dig("analysis_doi") }
    end

    context "when taggable_data is nil" do
      let(:analysis) { build :analysis, :with_realistic_attributes, taggable_data: nil }

      it { is_expected.to eq "" }
    end
  end

  describe "#kind" do
    subject(:kind) { analysis.kind }

    context "when extended_metadata is correctly filled" do
      it { is_expected.to eq analysis.extended_metadata&.dig("kind") }
    end

    context "when extended_metadata is nil" do
      let(:analysis) { build :analysis, :with_realistic_attributes, extended_metadata: nil }

      it { is_expected.to eq "" }
    end
  end

  describe "#ontologies" do
    subject(:ontologies) { analysis.ontologies }

    context "when kind is correctly filled" do
      let(:expected_ontologies) { "13C nuclear magnetic resonance spectroscopy (13C NMR)" }

      it { is_expected.to eq expected_ontologies }
    end

    context "when kind is filled without a |" do
      let(:analysis) {
        build :analysis, :with_realistic_attributes,
          extended_metadata: {"kind" => "CHMO:0000595 13C nuclear magnetic resonance spectroscopy (13C NMR)"}
      }

      let(:expected_ontologies) { "CHMO:0000595 13C nuclear magnetic resonance spectroscopy (13C NMR)" }

      it { is_expected.to eq expected_ontologies }
    end

    context "when extended_metadata is nil" do
      let(:analysis) { build :analysis, :with_realistic_attributes, extended_metadata: nil }

      it { is_expected.to eq "" }
    end
  end

  describe "#present_to_api" do
    subject(:present_to_api) { described_class.new.present_to_api }

    it { expect(present_to_api).to be_a RootMappers::AnalysisMapper }
  end
end
