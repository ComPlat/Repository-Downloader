describe Sample do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Sample" }

  describe "factories" do
    describe "with trait :with_required_dependencies" do
      subject(:factory) { build :sample, :with_required_dependencies }

      it { is_expected.to be_valid }
      it { expect(factory.save).to be true }
    end

    describe "with traits :with_required_dependencies and :with_realistic_attributes" do
      subject(:factory) { build :sample, :with_required_dependencies, :with_realistic_attributes }

      it { is_expected.to be_valid }
      it { expect(factory.save).to be true }
    end

    describe "without trait" do
      subject(:factory) { build :sample }

      it { is_expected.to be_invalid }
      it { expect(factory.save).to be false }
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:reaction).with_foreign_key(:ancestry).inverse_of :samples }

    describe "#reaction" do
      let(:reaction) { create :reaction }
      let(:sample) { create :sample, reaction: }

      it { expect(sample.reaction).to eq reaction }
      it { expect { create :sample }.to raise_error ActiveRecord::RecordInvalid, "Validation failed: Reaction must exist" }
    end
  end

  describe ".new" do
    subject(:sample) { create :sample, :with_required_dependencies }

    it { is_expected.to be_a described_class }
  end

  describe "#analyses" do
    subject(:analyses) { sample.analyses }

    context "when taggable_data is nil" do
      let(:sample) { build :sample, :with_required_dependencies, taggable_data: nil }

      it { is_expected.to eq [] }
    end

    context "when taggable_data is a Hash and has nil on key original_analysis_ids" do
      let(:sample) { build :sample, :with_required_dependencies, taggable_data: {"original_analysis_ids" => nil} }

      it { is_expected.to eq [] }
    end

    context "when taggable_data is a Hash and has an empty Array on key original_analysis_ids" do
      let(:sample) { build :sample, :with_required_dependencies, taggable_data: {"original_analysis_ids" => []} }

      it { is_expected.to eq [] }
    end

    context "when taggable_data is a Hash and has an Array on key original_analysis_ids with an id that no Analysis has" do
      let(:sample) { build :sample, :with_required_dependencies, taggable_data: {"original_analysis_ids" => [0]} }

      it { is_expected.to eq [] }
    end

    context "when taggable_data is a Hash and has an Array on key original_analysis_ids with id of an analysis in it" do
      let(:sample) { build :sample, :with_required_dependencies, taggable_data: {"original_analysis_ids" => [analysis.id]} }
      let(:analysis) { create :analysis, id: 1 }

      it { is_expected.to eq [analysis] }
    end
  end

  describe "#chemotion_id" do
    subject(:chemotion_id) { sample.chemotion_id }

    let(:sample) { create :sample, :with_required_dependencies, id: 1 }

    it { is_expected.to eq "CRS-#{sample.id}" }
    it { is_expected.to eq "CRS-1" }
  end

  describe "#present_to_api" do
    subject(:present_to_api) { described_class.new.present_to_api }

    it { is_expected.to be_a SamplePresenter }
  end
end
