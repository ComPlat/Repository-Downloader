# rubocop:disable RSpec/MultipleMemoizedHelpers

describe PublicationSearchOperation do
  describe "#new" do
    subject { described_class.new(authors, contributor, description) }

    let(:authors) { nil }
    let(:contributor) { nil }
    let(:description) { nil }

    it { is_expected.to be_a described_class }
  end

  describe ".search" do
    let!(:search) { described_class.new(authors, contributor, description).search }

    context "when no search parameters are given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }

      let(:authors) { nil }
      let(:contributor) { nil }
      let(:description) { nil }

      # TODO: When we have no search params should it return everything or nothing?
      it { expect(search).to eq [] }
    end

    context "when one author are given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }

      let(:authors) { [sample_author] }
      let(:contributor) { nil }
      let(:description) { nil }

      it { expect(search).to eq [sample.id] }
    end

    context "when multiple authors are given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }
      let(:reaction_author) { reaction.taggable_data["creators"].first["name"] }

      let(:authors) { [sample_author, reaction_author] }
      let(:contributor) { nil }
      let(:description) { nil }

      it { expect(search).to eq [sample.id, reaction.id] }
    end

    context "when only contributor is given" do
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }

      let(:authors) { nil }
      let(:contributor) { reaction_contributor }
      let(:description) { nil }

      it { expect(search).to eq [reaction.id] }
    end

    context "when reaction description is given" do
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:reaction_description) { reaction.reaction_description }

      let(:authors) { nil }
      let(:contributor) { nil }
      let(:description) { reaction_description }

      it { expect(search).to eq [reaction.id] }
    end

    context "when sample sample description is given" do
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:sample_description) { sample.sample_desc }

      let(:authors) { nil }
      let(:contributor) { nil }
      let(:description) { sample_description }

      it { expect(search).to eq [sample.id] }
    end

    context "when one contributor and an description is given" do
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:reaction_description) { reaction.reaction_description }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }

      let(:authors) { nil }
      let(:contributor) { reaction_contributor }
      let(:description) { reaction_description }

      it { expect(search).to eq [reaction.id] }
    end

    context "when one author and one contributor is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:reaction_author) { reaction.taggable_data["creators"].first["name"] }

      let(:authors) { [reaction_author] }
      let(:contributor) { reaction_contributor }
      let(:description) { nil }

      it { expect(search).to eq [reaction.id] }
    end

    context "when multiple authors and one contributor is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }
      let(:reaction_author) { reaction.taggable_data["creators"].first["name"] }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }

      let(:authors) { [sample_author, reaction_author] }
      let(:contributor) { reaction_contributor }
      let(:description) { nil }

      it { expect(search).to eq [reaction.id] }
    end

    context "when one author and a description is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:reaction_author) { reaction.taggable_data["creators"].first["name"] }
      let(:reaction_description) { reaction.reaction_description }

      let(:authors) { [reaction_author] }
      let(:contributor) { nil }
      let(:description) { reaction_description }

      it { expect(search).to eq [reaction.id] }
    end

    context "when multiple authors and a description is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }
      let(:reaction_author) { reaction.taggable_data["creators"].first["name"] }
      let(:reaction_description) { reaction.reaction_description }

      let(:authors) { [reaction_author, sample_author] }
      let(:contributor) { nil }
      let(:description) { reaction_description }

      it { expect(search).to eq [reaction.id] }
    end

    context "when one author, one contributor and a description is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:reaction_author) { reaction.taggable_data["creators"].first["name"] }
      let(:reaction_description) { reaction.reaction_description }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }

      let(:authors) { [reaction_author] }
      let(:contributor) { reaction_contributor }
      let(:description) { reaction_description }

      it { expect(search).to eq [reaction.id] }
    end

    context "when multiple authors, one contributor and a description is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }
      let(:reaction_author) { reaction.taggable_data["creators"].first["name"] }
      let(:reaction_description) { reaction.reaction_description }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }

      let(:authors) { [reaction_author, sample_author] }
      let(:contributor) { reaction_contributor }
      let(:description) { reaction_description }

      it { expect(search).to eq [reaction.id] }
    end

    context "when two not matching authors are given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }
      let(:reaction_author) { reaction.taggable_data["creators"].first["name"] }

      let(:authors) { [reaction_author, sample_author] }
      let(:contributor) { nil }
      let(:description) { nil }

      # TODO: Authors is multi select does this mean including or excluding
      it { expect(search).to eq [] }
    end

    xcontext "when a not matching author and contirbutor is given" do
    end

    xcontext "when a not matching author and description is given" do
    end

    xcontext "when a not matching contributor and description is given" do
    end

    xcontext "when a not matching author, contributor and description is given" do
    end
  end
end
