describe PublicationSearchOperation do
  describe "#new" do
    subject { described_class.new(params) }

    let(:params) do
      {authors_value: nil, authors_search_operator: nil,
       contributor_value: nil, contributor_search_operator: nil,
       description_value: nil, description_search_operator: nil}
    end

    it { is_expected.to be_a described_class }
  end

  describe "#search" do
    let(:search) { described_class.new(params) }

    # GENERAL

    context "when no search parameters are provided" do
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [] }
    end

    # AUTHORS

    context "when publications with one existing author is searched for with 'EQUAL'" do
      let(:publication) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:author_name) { publication.taggable_data["creators"].first["name"] }
      let(:params) do
        {authors_value: [author_name], authors_search_operator: [described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with one existing author is searched for with 'LIKE' and partial value" do
      let(:publication) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:partial_author_name) { publication.taggable_data["creators"].first["name"][1..] } # HINT: remove first character
      let(:params) do
        {authors_value: [partial_author_name], authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with two existing authors are searched for with 'EQUAL'" do
      let(:publication) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:author_name1) { publication.taggable_data["creators"].first["name"] }
      let(:author_name2) { publication.taggable_data["creators"].second["name"] }
      let(:params) do
        {authors_value: [author_name1, author_name2],
         authors_search_operator: [described_class::SEARCH_OPERATOR_EQUAL, described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with two existing authors are searched for, one with 'LIKE' and one with 'EQUAL'" do
      let(:publication) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:partial_author_name1) { publication.taggable_data["creators"].first["name"][1..] }
      let(:author_name2) { publication.taggable_data["creators"].second["name"] }
      let(:params) do
        {authors_value: [partial_author_name1, author_name2],
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE, described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with two existing authors are searched for with 'LIKE'" do
      let(:publication) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:partial_author_name1) { publication.taggable_data["creators"].first["name"][1..] }
      let(:partial_author_name2) { publication.taggable_data["creators"].second["name"][1..] }
      let(:params) do
        {authors_value: [partial_author_name1, partial_author_name2],
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE, described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with one not existing author is searched for with 'EQUAL'" do
      let(:params) do
        {authors_value: ["INVALID AUTHOR NAME"], authors_search_operator: [described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search.search).to eq [] }
    end

    context "when publications with one not existing author is searched for with 'LIKE'" do
      let(:params) do
        {authors_value: ["INVALID AUTHOR NAME"], authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search.search).to eq [] }
    end

    context "when publications with two not existing authors is searched for with 'EQUAL'" do
      let(:params) do
        {authors_value: ["INVALID AUTHOR NAME 1", "INVALID AUTHOR NAME 2"],
         authors_search_operator: [described_class::SEARCH_OPERATOR_EQUAL, described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      before { create(:reaction, :with_realistic_attributes_and_two_authors) }

      it { expect(search.search).to eq [] }
    end

    context "when publications with two not existing authors is searched for with 'LIKE'" do
      let(:params) do
        {authors_value: ["INVALID AUTHOR NAME 1", "INVALID AUTHOR NAME 2"],
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE, described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      before { create(:reaction, :with_realistic_attributes_and_two_authors) }

      it { expect(search.search).to eq [] }
    end

    context "when publications with two not existing authors is searched for, one with 'LIKE' and one with 'EQUAL'" do
      let(:params) do
        {authors_value: ["INVALID AUTHOR NAME 1", "INVALID AUTHOR NAME 2"],
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE, described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      before { create(:reaction, :with_realistic_attributes_and_two_authors) }

      it { expect(search.search).to eq [] }
    end

    context "when publications with one existing and one not existing authors are searched for with 'EQUAL'" do
      let(:publication) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:valid_author_name) { publication.taggable_data["creators"].first["name"] }
      let(:params) do
        {authors_value: [valid_author_name, "INVALID AUTHOR NAME"],
         authors_search_operator: [described_class::SEARCH_OPERATOR_EQUAL, described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [] }
    end

    context "when publications with one existing and one not existing authors are searched for with 'LIKE'" do
      let(:publication) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:valid_author_name) { publication.taggable_data["creators"].first["name"][1..] }
      let(:params) do
        {authors_value: [valid_author_name, "INVALID AUTHOR NAME"],
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE, described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [] }
    end

    context "when publications with one existing and one not existing authors are searched for with 'LIKE' and 'EQUAL'" do
      let(:publication) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:valid_author_name) { publication.taggable_data["creators"].first["name"][1..] }
      let(:params) do
        {authors_value: [valid_author_name, "INVALID AUTHOR NAME"],
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE, described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [] }
    end

    context "when publications with one existing and one not existing authors are searched for with 'EQUAL' and 'LIKE'" do
      let(:publication) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:valid_author_name) { publication.taggable_data["creators"].first["name"] }
      let(:params) do
        {authors_value: [valid_author_name, "INVALID AUTHOR NAME"],
         authors_search_operator: [described_class::SEARCH_OPERATOR_EQUAL, described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: nil, contributor_search_operator: nil,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [] }
    end

    # CONTRIBUTOR

    context "when publications with existing contributor is searched for with 'EQUAL'" do
      let(:publication) { create(:reaction, :with_realistic_attributes) }
      let(:contributor) { publication.taggable_data["contributors"]["name"] }
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: contributor, contributor_search_operator: described_class::SEARCH_OPERATOR_EQUAL,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with existing contributor is searched for with 'LIKE'" do
      let(:publication) { create(:reaction, :with_realistic_attributes) }
      let(:contributor) { publication.taggable_data["contributors"]["name"][1..] }
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: contributor, contributor_search_operator: described_class::SEARCH_OPERATOR_LIKE,
         description_value: nil, description_search_operator: nil}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with not existing contributor is searched for with 'EQUAL'" do
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: "NOT EXISTING", contributor_search_operator: described_class::SEARCH_OPERATOR_EQUAL,
         description_value: nil, description_search_operator: nil}
      end

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search.search).to eq [] }
    end

    context "when publications with not existing contributor is searched for with 'LIKE'" do
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: "NOT EXISTING", contributor_search_operator: described_class::SEARCH_OPERATOR_LIKE,
         description_value: nil, description_search_operator: nil}
      end

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search.search).to eq [] }
    end

    # DESCRIPTION

    context "when publications with existing sample description is searched for with 'EQUAL'" do
      let(:publication) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:description) { publication.sample_desc }
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: nil, contributor_search_operator: nil,
         description_value: description, description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with existing sample description is searched for with 'LIKE'" do
      let(:publication) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:description) { publication.sample_desc[1..] }
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: nil, contributor_search_operator: nil,
         description_value: description, description_search_operator: described_class::SEARCH_OPERATOR_LIKE}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with not existing sample description is searched for with 'EQUAL'" do
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: nil, contributor_search_operator: nil,
         description_value: "INVALID DESCRIPTION", description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search.search).to eq [] }
    end

    context "when publications with not existing sample description is searched for with 'LIKE'" do
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: nil, contributor_search_operator: nil,
         description_value: "INVALID DESCRIPTION", description_search_operator: described_class::SEARCH_OPERATOR_LIKE}
      end

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search.search).to eq [] }
    end

    context "when publications with existing reaction description is searched for with 'EQUAL'" do
      let(:publication) { create(:reaction, :with_realistic_attributes) }
      let(:description) { publication.reaction_description }
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: nil, contributor_search_operator: nil,
         description_value: description, description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with existing reaction description is searched for with 'LIKE'" do
      let(:publication) { create(:reaction, :with_realistic_attributes) }
      let(:description) { publication.reaction_description[1..] }
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: nil, contributor_search_operator: nil,
         description_value: description, description_search_operator: described_class::SEARCH_OPERATOR_LIKE}
      end

      it { expect(search.search).to eq [publication.id] }
    end

    context "when publications with not existing reaction description is searched for with 'EQUAL'" do
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: nil, contributor_search_operator: nil,
         description_value: "INVALID DESCRIPTION", description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search.search).to eq [] }
    end

    context "when publications with not existing reaction description is searched for with 'LIKE'" do
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: nil, contributor_search_operator: nil,
         description_value: "INVALID DESCRIPTION", description_search_operator: described_class::SEARCH_OPERATOR_LIKE}
      end

      before { create(:reaction, :with_realistic_attributes) }

      it { expect(search.search).to eq [] }
    end

    # COMBINED

    context "when publications with one contributor and an description are searched" do
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:params) do
        {authors_value: nil, authors_search_operator: nil,
         contributor_value: reaction.taggable_data["contributors"]["name"],
         contributor_search_operator: described_class::SEARCH_OPERATOR_EQUAL,
         description_value: reaction.reaction_description,
         description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search.search).to eq [reaction.id] }
    end

    context "when publications with one author and one contributor are searched" do
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:params) do
        {authors_value: [reaction.taggable_data["creators"].first["name"]],
         authors_search_operator: [described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: reaction.taggable_data["contributors"]["name"],
         contributor_search_operator: described_class::SEARCH_OPERATOR_LIKE,
         description_value: nil,
         description_search_operator: nil}
      end

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search.search).to eq [reaction.id] }
    end

    context "when publications with multiple authors and one contributor are searched" do
      let(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:params) do
        {authors_value: [reaction.taggable_data["creators"].first["name"], reaction.taggable_data["creators"].second["name"]],
         authors_search_operator: [described_class::SEARCH_OPERATOR_EQUAL, described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: reaction.taggable_data["contributors"]["name"],
         contributor_search_operator: described_class::SEARCH_OPERATOR_LIKE,
         description_value: nil,
         description_search_operator: nil}
      end

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search.search).to eq [reaction.id] }
    end

    context "when publications with one author and a description are searched" do
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:params) do
        {authors_value: [reaction.taggable_data["creators"].first["name"]],
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: nil,
         contributor_search_operator: nil,
         description_value: reaction.reaction_description,
         description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search.search).to eq [reaction.id] }
    end

    context "when publications with multiple authors and a description are searched" do
      let(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:params) do
        {authors_value: [reaction.taggable_data["creators"].first["name"], reaction.taggable_data["creators"].second["name"]],
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE, described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: nil,
         contributor_search_operator: nil,
         description_value: reaction.reaction_description,
         description_search_operator: described_class::SEARCH_OPERATOR_LIKE}
      end

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search.search).to eq [reaction.id] }
    end

    context "when publications with one author, one contributor and a description are searched" do
      let(:reaction) { create(:reaction, :with_realistic_attributes) }
      let(:params) do
        {authors_value: [reaction.taggable_data["creators"].first["name"]],
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: reaction.taggable_data["contributors"]["name"],
         contributor_search_operator: described_class::SEARCH_OPERATOR_LIKE,
         description_value: reaction.reaction_description,
         description_search_operator: described_class::SEARCH_OPERATOR_LIKE}
      end

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search.search).to eq [reaction.id] }
    end

    context "when publications with multiple authors, one contributor and a description are searched" do
      let(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:params) do
        {authors_value: [reaction.taggable_data["creators"].first["name"], reaction.taggable_data["creators"].last["name"]],
         authors_search_operator: [described_class::SEARCH_OPERATOR_EQUAL, described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: reaction.taggable_data["contributors"]["name"],
         contributor_search_operator: described_class::SEARCH_OPERATOR_EQUAL,
         description_value: reaction.reaction_description,
         description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      before { create(:sample, :with_required_dependencies, :with_realistic_attributes) }

      it { expect(search.search).to eq [reaction.id] }
    end

    context "when publications with a not matching author and contributor are searched" do
      let(:authors) do
        [create(:sample, :with_required_dependencies, :with_realistic_attributes)
          .taggable_data["creators"].first["name"]]
      end
      let(:contributor) { create(:reaction, :with_realistic_attributes).taggable_data["contributors"]["name"] }
      let(:params) do
        {authors_value: authors,
         authors_search_operator: [described_class::SEARCH_OPERATOR_EQUAL],
         contributor_value: contributor,
         contributor_search_operator: described_class::SEARCH_OPERATOR_EQUAL,
         description_value: nil,
         description_search_operator: nil}
      end

      it { expect(search.search).to eq [] }
    end

    context "when publications with a not matching author and description are searched" do
      let(:authors) do
        [create(:sample, :with_required_dependencies, :with_realistic_attributes)
          .taggable_data["creators"].first["name"]]
      end
      let(:description) { create(:reaction, :with_realistic_attributes).reaction_description }
      let(:params) do
        {authors_value: authors,
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: nil,
         contributor_search_operator: nil,
         description_value: description,
         description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      it { expect(search.search).to eq [] }
    end

    context "when publications with a not matching contributor and description are searched" do
      let(:contributor) { create(:reaction, :with_realistic_attributes).taggable_data["contributors"]["name"] }
      let(:description) { create(:sample, :with_required_dependencies, :with_realistic_attributes).sample_desc }
      let(:params) do
        {authors_value: nil,
         authors_search_operator: nil,
         contributor_value: contributor,
         contributor_search_operator: described_class::SEARCH_OPERATOR_LIKE,
         description_value: description,
         description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      it { expect(search.search).to eq [] }
    end

    context "when publications with a not matching author, contributor and description are searched" do
      let(:sample) { create(:sample, :with_required_dependencies, :with_realistic_attributes) }
      let(:authors) { [sample.taggable_data["creators"].first["name"]] }
      let(:contributor) { create(:reaction, :with_realistic_attributes).taggable_data["contributors"]["name"] }
      let(:params) do
        {authors_value: authors,
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: contributor,
         contributor_search_operator: described_class::SEARCH_OPERATOR_LIKE,
         description_value: sample.sample_desc,
         description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      it { expect(search.search).to eq [] }
    end

    context "when publications with one matching and one not matching author, contributor and description are searched" do
      let(:reaction) { create(:reaction, :with_realistic_attributes_and_two_authors) }
      let(:authors) do
        [create(:sample, :with_required_dependencies, :with_realistic_attributes_and_two_authors)
          .taggable_data["creators"].second["name"], reaction.taggable_data["creators"].second["name"]]
      end
      let(:contributor) { reaction.taggable_data["contributors"]["name"] }
      let(:params) do
        {authors_value: authors,
         authors_search_operator: [described_class::SEARCH_OPERATOR_LIKE],
         contributor_value: contributor,
         contributor_search_operator: described_class::SEARCH_OPERATOR_LIKE,
         description_value: reaction.reaction_description,
         description_search_operator: described_class::SEARCH_OPERATOR_EQUAL}
      end

      it { expect(search.search).to eq [] }
    end
  end
end
