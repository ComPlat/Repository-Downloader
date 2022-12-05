describe AnalysisPresenter do
  let(:analysis) { build :analysis }
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

  describe "#to_zip" do
    subject(:to_zip) { analysis_presenter.to_zip }

    # let(:io) { StringIO.new([].join(->(e) { to_zip.each { |chunk| e << chunk } })) }

    before do
      zip_string = []
      to_zip.each { |x| zip_string << x }

      FileUtils.mkpath "tmp/data/output/data"

      io = StringIO.new(zip_string.join)

      ZipTricks::FileReader.read_zip_structure(io:).each do |entry|
        File.open("tmp/data/output/#{entry.filename}", "wb") do |extracted_file|
          inflated_reader = entry.extractor_from io
          extracted_file << inflated_reader.extract until inflated_reader.eof?
        end
      end
    end

    after do
      FileUtils.rm_rf "tmp/data/output"
    end

    context "when analysis has minimal attributes" do
      it { is_expected.to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.new("tmp/data/output").entries.size).to eq 9 }
      it { expect(File.read("tmp/data/output/data/analysis.json")).to eq analysis_presenter.to_json.to_a.join }
      it { expect(File.read("tmp/data/output/data/analysis.xml")).to eq analysis_presenter.to_xml.to_a.join }
      it { expect(File.read("tmp/data/output/data/analysis.csv")).to eq analysis_presenter.to_csv.to_a.join }
    end

    context "when analysis has realistic attributes" do
      let(:analysis) { build :analysis, :with_realistic_attributes }

      it { is_expected.to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.new("tmp/data/output").entries.size).to eq 9 }
      it { expect(File.read("tmp/data/output/data/analysis.json")).to eq analysis_presenter.to_json.to_a.join }
      it { expect(File.read("tmp/data/output/data/analysis.xml")).to eq analysis_presenter.to_xml.to_a.join }
      it { expect(File.read("tmp/data/output/data/analysis.csv")).to eq analysis_presenter.to_csv.to_a.join }
    end
  end
end
