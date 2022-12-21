require "dry-files"

describe AnalysisPresenter do
  let(:analysis) { create(:analysis, :with_realistic_attributes) }
  let(:analysis_presenter) { described_class.new analysis }

  describe ".new" do
    subject(:new) { analysis_presenter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) { analysis_presenter.to_json }

    it { is_expected.to be_a Enumerator }
    it { expect(to_json.to_a.join).to eq RootMappers::AnalysisMapper.from_hash(RootAdapters::AnalysisToAnalysisMapperAdapter.new(analysis).to_h).to_json }
  end

  describe "#to_xml" do
    subject(:to_xml) { analysis_presenter.to_xml }

    it { is_expected.to be_a Enumerator }
    it { expect(to_xml.to_a.join).to eq RootMappers::AnalysisMapper.from_hash(RootAdapters::AnalysisToAnalysisMapperAdapter.new(analysis).to_h).to_xml }
  end

  describe "#to_csv" do
    subject(:to_csv) { analysis_presenter.to_csv }

    it { is_expected.to be_a Enumerator }
    it { expect(to_csv.to_a.join).to eq RootMappers::AnalysisMapper.from_hash(RootAdapters::AnalysisToAnalysisMapperAdapter.new(analysis).to_h).to_csv }
  end
end
