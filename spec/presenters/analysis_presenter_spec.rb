describe AnalysisPresenter do
  let(:analysis) { build :analysis }
  let(:analysis_presenter) { described_class.new analysis }

  describe ".new" do
    subject(:new) { analysis_presenter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject { analysis_presenter.to_json }

    it { is_expected.to eq RootMappers::AnalysisMapper.from_hash(RootAdapters::AnalysisToAnalysisMapperAdapter.new(analysis).to_h).to_json }
  end

  describe "#to_xml" do
    subject { analysis_presenter.to_xml }

    it { is_expected.to eq RootMappers::AnalysisMapper.from_hash(RootAdapters::AnalysisToAnalysisMapperAdapter.new(analysis).to_h).to_xml }
  end

  describe "#to_csv" do
    subject { analysis_presenter.to_csv }

    it { is_expected.to eq RootMappers::AnalysisMapper.from_hash(RootAdapters::AnalysisToAnalysisMapperAdapter.new(analysis).to_h).to_csv }
  end

  describe "#to_zip" do
    subject { analysis_presenter.to_zip }

    it { is_expected.to be_nil }
  end
end
