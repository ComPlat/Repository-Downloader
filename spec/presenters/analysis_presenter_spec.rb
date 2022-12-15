describe AnalysisPresenter do
  let(:analysis) { create :analysis }
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

    before do
      zip_chunks = []
      to_zip.each { |zip_chunk|
        zip_chunks << zip_chunk
      }

      FileUtils.mkpath "tmp/output/data"

      io = StringIO.new(zip_chunks.join)

      ZipTricks::FileReader.read_zip_structure(io:).each do |entry|
        File.open("tmp/output/#{entry.filename}", "wb") do |extracted_file|
          inflated_reader = entry.extractor_from io
          extracted_file << inflated_reader.extract until inflated_reader.eof?
        end
      end
    end

    after do
      FileUtils.rm_rf "tmp/output"
      FileUtils.rm_rf "tmp/bagit"
    end

    context "when analysis has minimal attributes" do
      it { is_expected.to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.new("tmp/output").entries.size).to eq 9 }
      it { expect(File.read("tmp/output/data/analysis.json")).to eq analysis_presenter.to_json.to_a.join }
      it { expect(File.read("tmp/output/data/analysis.xml")).to eq analysis_presenter.to_xml.to_a.join }
      it { expect(File.read("tmp/output/data/analysis.csv")).to eq analysis_presenter.to_csv.to_a.join }
      it { expect(BagIt::Bag.new("tmp/output").valid?).to be true }
    end

    context "when analysis has realistic attributes" do
      let(:analysis) { create :analysis, :with_realistic_attributes }

      it { is_expected.to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.new("tmp/output").entries.size).to eq 9 }
      it { expect(File.read("tmp/output/data/analysis.json")).to eq analysis_presenter.to_json.to_a.join }
      it { expect(File.read("tmp/output/data/analysis.xml")).to eq analysis_presenter.to_xml.to_a.join }
      it { expect(File.read("tmp/output/data/analysis.csv")).to eq analysis_presenter.to_csv.to_a.join }
      it { expect(BagIt::Bag.new("tmp/output").valid?).to be true }
    end
  end
end
