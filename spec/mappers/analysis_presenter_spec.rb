describe AnalysisPresenter do
  context "when doi is given" do
    subject(:present) { described_class.present }

    let(:analysis) { create :analysis, :with_realistic_attributes }
    let(:analysis_record) { AnalysisRepository.find_by_doi! doi }
    let(:arg) { analysis.taggable_data["doi"] }

    xit { is_expected.to eq "" }
  end
end
