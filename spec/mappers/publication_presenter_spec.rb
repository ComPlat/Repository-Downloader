describe PublicationPresenter do
  describe ".present_by_doi" do
    context "when an existing doi is given" do
      subject(:present) { described_class.present_by_doi analysis.taggable_data["doi"] }

      let(:analysis) { create :analysis, :with_realistic_attributes }

      it { is_expected.to eq "" }
    end
  end
end
