describe Analysis do
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

    describe "#chemotion_id" do
      subject(:chemotion_id) { analysis.chemotion_id }

      it { is_expected.to eq "CRD-#{analysis.id}" }
    end

    describe "#content" do
      subject(:content) { analysis.content }

      it { is_expected.to eq JSON.parse(analysis.extended_metadata&.dig("content").to_json) }
    end

    describe "#doi" do
      subject(:doi) { analysis.doi }

      it { is_expected.to eq analysis.taggable_data&.dig("analysis_doi") }
    end

    describe "#kind" do
      subject(:kind) { analysis.kind }

      it { is_expected.to eq analysis.extended_metadata&.dig("kind") }
    end

    describe "#present_to_api" do
      subject(:present_to_api) { described_class.new.present_to_api }

      it { expect(present_to_api).to be_a RootMappers::AnalysisMapper }
    end
  end
end
