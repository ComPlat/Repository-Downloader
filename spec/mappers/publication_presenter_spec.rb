describe PublicationPresenter do
  describe ".present_by_doi" do
    context "when an existing doi is given" do
      subject(:present) { described_class.present_by_doi analysis.taggable_data["doi"] }

      let(:analysis) { create :analysis, :with_realistic_attributes }

      it { expect(present.to_json).to eq analysis.present_to_api.to_json }
      it { expect(present.to_xml).to eq analysis.present_to_api.to_xml }
      it { expect(present.to_csv).to eq analysis.present_to_api.to_csv }
    end
  end
end
