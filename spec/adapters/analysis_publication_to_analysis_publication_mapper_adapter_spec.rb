describe AnalysisPublicationToAnalysisPublicationMapperAdapter do
  let(:analysis_publication) { build :analysis_publication }

  describe ".new" do
    subject { described_class.new(analysis_publication) }

    it { is_expected.to be_a described_class }
  end

  describe "#mapper_args" do
    subject { described_class.new(analysis_publication).mapper_args }

    it { is_expected.to be_nil }
  end
end
