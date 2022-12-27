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

    context "when one author is given and publication with that author exists" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }

      let(:authors) { [sample_author] }
      let(:contributor) { nil }
      let(:description) { nil }

      it { expect(search).to eq [sample.id] }
    end

    context "when one author is given and publication with that author and one other author exists" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes_and_two_authors) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }

      let(:authors) { [sample_author] }
      let(:contributor) { nil }
      let(:description) { nil }

      it { expect(search).to eq [sample.id] }
    end

    context "when one author is given and publication with that author does not exists" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:not_existing_author) { "Mister X." }

      let(:authors) { [not_existing_author] }
      let(:contributor) { nil }
      let(:description) { nil }

      it { expect(search).to eq [] }
    end

    context "when multiple authors are given and publication with these authors exists" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes_and_two_authors) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author1) { sample.taggable_data["creators"].first["name"] }
      let(:sample_author2) { sample.taggable_data["creators"].second["name"] }

      let(:authors) { [sample_author1, sample_author2] }
      let(:contributor) { nil }
      let(:description) { nil }

      it { expect(search).to eq [sample.id] }
    end

    context "when multiple authors are given and publication with only one of these authors exists" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author1) { sample.taggable_data["creators"].first["name"] }
      let(:not_existing_author) { "Mister X." }

      let(:authors) { [sample_author1, not_existing_author] }
      let(:contributor) { nil }
      let(:description) { nil }

      it { expect(search).to eq [] }
    end

    context "when multiple authors are given and no publication for these authors exists" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:not_existing_author1) { "Mister X." }
      let(:not_existing_author2) { "Miss. Y." }

      let(:authors) { [not_existing_author1, not_existing_author2] }
      let(:contributor) { nil }
      let(:description) { nil }

      it { expect(search).to eq [] }
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
      let!(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:reaction_author1) { reaction.taggable_data["creators"].first["name"] }
      let(:reaction_author2) { reaction.taggable_data["creators"].second["name"] }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }

      let(:authors) { [reaction_author1, reaction_author2] }
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
      let!(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:reaction_author1) { reaction.taggable_data["creators"].first["name"] }
      let(:reaction_author2) { reaction.taggable_data["creators"].second["name"] }
      let(:reaction_description) { reaction.reaction_description }

      let(:authors) { [reaction_author1, reaction_author2] }
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
      let!(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:reaction_author1) { reaction.taggable_data["creators"].first["name"] }
      let(:reaction_author2) { reaction.taggable_data["creators"].last["name"] }
      let(:reaction_description) { reaction.reaction_description }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }

      let(:authors) { [reaction_author1, reaction_author2] }
      let(:contributor) { reaction_contributor }
      let(:description) { reaction_description }

      it { expect(search).to eq [reaction.id] }
    end

    context "when a not matching author and contirbutor is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }

      let(:authors) { [sample_author] }
      let(:contributor) { reaction_contributor }
      let(:description) { nil }

      it { expect(search).to eq [] }
    end

    context "when a not matching author and description is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }
      let(:reaction_description) { reaction.reaction_description }

      let(:authors) { [sample_author] }
      let(:contributor) { nil }
      let(:description) { reaction_description }

      it { expect(search).to eq [] }
    end

    context "when a not matching contributor and description is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:sample_description) { sample.sample_desc }

      let(:authors) { [] }
      let(:contributor) { reaction_contributor }
      let(:description) { sample_description }

      it { expect(search).to eq [] }
    end

    context "when a not matching author, contributor and description is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:sample_description) { sample.sample_desc }

      let(:authors) { [sample_author] }
      let(:contributor) { reaction_contributor }
      let(:description) { sample_description }

      it { expect(search).to eq [] }
    end

    context "when one matching and one not matching author, contributor and description is given" do
      let!(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let!(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }
      let(:reaction_author) { reaction.taggable_data["creators"].first["name"] }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:reaction_description) { reaction.reaction_description }

      let(:authors) { [sample_author, reaction_author] }
      let(:contributor) { reaction_contributor }
      let(:description) { reaction_description }

      it { expect(search).to eq [reaction.id] }
    end
  end
end
