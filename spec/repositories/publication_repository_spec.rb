describe PublicationRepository do
  let(:analysis1) { create(:analysis, :with_realistic_attributes) }
  let(:analysis2) { create(:analysis, :with_realistic_attributes, taggable_data: {analysis_doi: analysis1.doi.tr("N", "Z")}) }
  let(:reaction1) { create(:reaction, :with_realistic_attributes) }
  let(:reaction2) { create(:reaction, :with_realistic_attributes, taggable_data: {doi: reaction1.doi.tr("N", "Z")}) }

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
end
