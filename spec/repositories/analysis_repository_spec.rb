describe AnalysisRepository do
  let(:analysis) { create :analysis, :with_realistic_attributes }

  describe ".find_by_doi" do
    # HINT: Rubocop thinks this is the slow dynamic method, but we implement it ourselves!
    # rubocop:disable Rails/DynamicFindBy
    subject(:find_by_doi) { described_class.find_by_doi! arg }

    context "when an Analysis can be found" do
      let(:arg) { analysis.taggable_data["doi"] }

      it { is_expected.to eq analysis }
    end

    context "when NO Analysis can be found" do
      let(:arg) { 0 }

      it { expect { find_by_doi }.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe ".find_by_chemotion_id" do
    subject(:find_by_chemotion_id) { described_class.find_by_chemotion_id! arg }

    context "when an Analysis can be found" do
      let(:arg) { analysis.id }

      it { is_expected.to eq analysis }
    end

    context "when NO Analysis can be found" do
      let(:arg) { 0 }

      it { expect { find_by_chemotion_id }.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
