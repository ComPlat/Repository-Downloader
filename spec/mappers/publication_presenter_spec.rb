describe PublicationPresenter do
  let(:analysis) { create :analysis, :with_realistic_attributes }

  describe ".present_by_doi" do
    context "when an existing doi is given" do
      subject(:present_by_doi) { described_class.present_by_doi analysis.taggable_data["doi"] }

      it { expect(present_by_doi.to_json).to eq analysis.present_to_api.to_json }
      it { expect(present_by_doi.to_xml).to eq analysis.present_to_api.to_xml }
      it { expect(present_by_doi.to_csv).to eq analysis.present_to_api.to_csv }
    end

    context "when an NOT existing doi is given" do
      subject(:present_by_doi) { described_class.present_by_doi "fake_doi" }

      it { expect { present_by_doi }.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe ".present_by_chemotion_id" do
    context "when an existing chemotion_id is given" do
      subject(:present_by_chemotion_id) { described_class.present_by_chemotion_id analysis.id }

      it { expect(present_by_chemotion_id.to_json).to eq analysis.present_to_api.to_json }
      it { expect(present_by_chemotion_id.to_xml).to eq analysis.present_to_api.to_xml }
      it { expect(present_by_chemotion_id.to_csv).to eq analysis.present_to_api.to_csv }
    end

    context "when an NOT existing chemotion_id is given" do
      subject(:present_by_chemotion_id) { described_class.present_by_chemotion_id 0 }

      it { expect { present_by_chemotion_id }.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
