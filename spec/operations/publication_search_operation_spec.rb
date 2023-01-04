describe PublicationSearchOperation do
  describe "#new" do
    subject { described_class.new(authors, contributor, description) }

    let(:authors) { nil }
    let(:contributor) { nil }
    let(:description) { nil }

    it { is_expected.to be_a described_class }
  end

  describe ".search" do
    let(:search) { described_class.new(authors, contributor, description).search }

    context "when no search parameters are given" do
      let(:authors) { nil }
      let(:contributor) { nil }
      let(:description) { nil }

      before do
        create(:sample, :with_required_dependencies, :with_realistic_attributes)
        create(:reaction, :with_realistic_attributes)
      end

      it { expect(search).to eq [] }
    end

    context "when one author is given and publication with that author exists" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:authors) { [sample.taggable_data["creators"].first["name"]] }
      let(:contributor) { nil }
      let(:description) { nil }

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search).to eq [sample.id] }
    end

    context "when one author is given and publication with that author and one other author exists" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes_and_two_authors) }
      let(:authors) { [sample.taggable_data["creators"].first["name"]] }
      let(:contributor) { nil }
      let(:description) { nil }

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search).to eq [sample.id] }
    end

    context "when one author is given and publication with that author does not exists" do
      let(:not_existing_author) { "Mister X." }
      let(:authors) { [not_existing_author] }
      let(:contributor) { nil }
      let(:description) { nil }

      before do
        create(:sample, :with_required_dependencies, :with_realistic_attributes)
        create(:reaction, :with_realistic_attributes)
      end

      it { expect(search).to eq [] }
    end

    context "when multiple authors are given and publication with these authors exists" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes_and_two_authors) }
      let(:authors) do
        [sample.taggable_data["creators"].first["name"], sample.taggable_data["creators"].second["name"]]
      end
      let(:contributor) { nil }
      let(:description) { nil }

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search).to eq [sample.id] }
    end

    context "when multiple authors are given and publication with only one of these authors exists" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:authors) { [sample.taggable_data["creators"].first["name"], "Not Existing Author Name"] }
      let(:contributor) { nil }
      let(:description) { nil }

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search).to eq [] }
    end

    context "when multiple authors are given and no publication for these authors exists" do
      let(:authors) { ["Not Existing Author Name 1", "Not Existing Author Name 2"] }
      let(:contributor) { nil }
      let(:description) { nil }

      before do
        create(:sample, :with_required_dependencies, :with_realistic_attributes)
        create(:reaction, :with_realistic_attributes)
      end

      it { expect(search).to eq [] }
    end

    context "when only contributor is given" do
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:authors) { nil }
      let(:contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:description) { nil }

      it { expect(search).to eq [reaction.id] }
    end

    context "when reaction description is given" do
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:authors) { nil }
      let(:contributor) { nil }
      let(:description) { reaction.reaction_description }

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search).to eq [reaction.id] }
    end

    context "when sample sample description is given" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:authors) { nil }
      let(:contributor) { nil }
      let(:description) { sample.sample_desc }

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search).to eq [sample.id] }
    end

    context "when one contributor and an description is given" do
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:authors) { nil }
      let(:contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:description) { reaction.reaction_description }

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search).to eq [reaction.id] }
    end

    context "when one author and one contributor is given" do
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:authors) { [reaction.taggable_data["creators"].first["name"]] }
      let(:contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:description) { nil }

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search).to eq [reaction.id] }
    end

    context "when multiple authors and one contributor is given" do
      let(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:authors) do
        [reaction.taggable_data["creators"].first["name"], reaction.taggable_data["creators"].second["name"]]
      end
      let(:contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:description) { nil }

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search).to eq [reaction.id] }
    end

    context "when one author and a description is given" do
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:authors) { [reaction.taggable_data["creators"].first["name"]] }
      let(:contributor) { nil }
      let(:description) { reaction.reaction_description }

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search).to eq [reaction.id] }
    end

    context "when multiple authors and a description is given" do
      let(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:authors) do
        [reaction.taggable_data["creators"].first["name"], reaction.taggable_data["creators"].second["name"]]
      end
      let(:contributor) { nil }
      let(:description) { reaction.reaction_description }

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search).to eq [reaction.id] }
    end

    context "when one author, one contributor and a description is given" do
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:authors) { [reaction.taggable_data["creators"].first["name"]] }
      let(:contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:description) { reaction.reaction_description }

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search).to eq [reaction.id] }
    end

    context "when multiple authors, one contributor and a description is given" do
      let(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:authors) do
        [reaction.taggable_data["creators"].first["name"], reaction.taggable_data["creators"].last["name"]]
      end
      let(:contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:description) { reaction.reaction_description }

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search).to eq [reaction.id] }
    end

    context "when a not matching author and contributor is given" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:sample_author) { sample.taggable_data["creators"].first["name"] }
      let(:reaction_contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:authors) { [sample_author] }
      let(:contributor) { reaction_contributor }
      let(:description) { nil }

      it { expect(search).to eq [] }
    end

    context "when a not matching author and description is given" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:authors) { [sample.taggable_data["creators"].first["name"]] }
      let(:contributor) { nil }
      let(:description) { reaction.reaction_description }

      it { expect(search).to eq [] }
    end

    context "when a not matching contributor and description is given" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:authors) { [] }
      let(:contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:description) { sample.sample_desc }

      it { expect(search).to eq [] }
    end

    context "when a not matching author, contributor and description is given" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:authors) { [sample.taggable_data["creators"].first["name"]] }
      let(:contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:description) { sample.sample_desc }

      it { expect(search).to eq [] }
    end

    context "when one matching and one not matching author, contributor and description is given" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes_and_two_authors) }
      let(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:authors) do
        [sample.taggable_data["creators"].second["name"], reaction.taggable_data["creators"].second["name"]]
      end
      let(:contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:description) { reaction.reaction_description }

      it { expect(search).to eq [] }
    end
  end
end
