describe AnalysisToAnalysisMapperAdapter do
  let(:analysis) { build :analysis, :with_realistic_attributes }
  let(:analysis_to_analysis_mapper_adapter) { described_class.new analysis }

  describe ".new" do
    subject { analysis_to_analysis_mapper_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { analysis_to_analysis_mapper_adapter.to_h }

    let(:expected_hash) {
      {context: "https://schema.org/",
       datasetList: {},
       descriptions: "",
       id: "",
       identifier: "",
       ontologies: "",
       title: "",
       type: "AnalysisEntity",
       url: ""}
    }

    it { is_expected.to eq expected_hash }
  end

  describe "#context" do
    subject { analysis_to_analysis_mapper_adapter.context }

    it { is_expected.to eq "https://schema.org/" }
  end
end
