describe AnalysisPublicationMapper do
  context "when called without any arguments" do
    let(:analysis_publication_mapper) { build :analysis_publication_mapper }

    it { expect(analysis_publication_mapper).to be_a described_class }
    it { expect(analysis_publication_mapper).to be_a ShaleCustom::Mapper }
  end
end
