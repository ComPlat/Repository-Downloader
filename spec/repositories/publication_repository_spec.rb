describe PublicationRepository do
  let(:analysis1) { create(:analysis, :with_realistic_attributes) }
  let(:analysis2) { create(:analysis, :with_realistic_attributes, taggable_data: {analysis_doi: analysis1.doi.tr("N", "Z")}) }
  let(:reaction1) { create(:reaction, :with_realistic_attributes) }
  let(:reaction2) { create(:reaction, :with_realistic_attributes, taggable_data: {doi: reaction1.doi.tr("N", "Z")}) }

  describe ".find_by_doi" do
    # HINT: Rubocop thinks this is the slow dynamic method, but we implement it ourselves!
    # rubocop:disable Rails/DynamicFindBy
    subject(:find_by_doi) { described_class.find_by_doi! doi }
    # rubocop:enable Rails/DynamicFindBy

    context "when an Analysis can be found" do
      before {
        analysis2
        reaction1
        reaction2
      }

      let(:doi) { analysis1.doi }

      it { is_expected.to eq analysis1 }
    end

    context "when a Reaction can be found" do
      before {
        analysis1
        analysis2
        reaction2
      }

      let(:doi) { reaction1.doi }

      it { is_expected.to eq reaction1 }
    end

    context "when NO Publication can be found" do
      before {
        analysis1
        analysis2
        reaction1
        reaction2
      }

      let(:doi) { "not_a_doi" }

      it { expect { find_by_doi }.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe ".where_dois" do
    subject(:where_dois) { described_class.where_dois dois }

    before {
      analysis1
      analysis2
      reaction1
      reaction2
    }

    context "when one Analysis can be found" do
      let(:dois) { [analysis1.doi] }

      it { is_expected.to match_array [analysis1] }
    end

    context "when one Reaction can be found" do
      let(:dois) { [reaction1.doi] }

      it { is_expected.to match_array [reaction1] }
    end

    context "when two Reactions can be found" do
      let(:dois) { [reaction1.doi, reaction2.doi] }

      it { is_expected.to match_array [reaction1, reaction2] }
    end

    context "when two Analyses can be found" do
      let(:dois) { [analysis1.doi, analysis2.doi] }

      it { is_expected.to match_array [analysis1, analysis2] }
    end

    context "when NO Publication can be found" do
      let(:dois) { ["not_a_doi"] }

      it { is_expected.to match_array [] }
    end
  end

  describe ".find_by_chemotion_id" do
    # rubocop:disable Rails/DynamicFindBy
    subject(:find_by_chemotion_id) { described_class.find_by_chemotion_id! arg }
    # rubocop:enable Rails/DynamicFindBy

    context "when an Analysis can be found" do
      let(:arg) { analysis1.id }

      it { is_expected.to eq analysis1 }
    end

    context "when NO Analysis can be found" do
      let(:arg) { 0 }

      it { expect { find_by_chemotion_id }.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
