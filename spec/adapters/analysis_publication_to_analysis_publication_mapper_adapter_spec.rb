describe AnalysisPublicationToAnalysisPublicationMapperAdapter do
  describe ".new" do
    subject { described_class.new(analysis_publication) }

    xit { is_expected.to be_a described_class }
  end

  describe "#mapper_args" do
    subject { described_class.new(analysis_publication).mapper_args }

    let(:analysis_publication) { build :analysis_publication }

    xit { is_expected.to eq "" }
  end
end
