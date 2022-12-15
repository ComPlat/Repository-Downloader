describe SamplePresenter do
  let(:sample) { create :sample, :with_required_dependencies }
  let(:sample_presenter) { described_class.new sample }

  describe ".new" do
    subject(:new) { sample_presenter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) { sample_presenter.to_json }

    it { is_expected.to be_a Enumerator }
    it { expect(to_json.to_a.join).to eq RootMappers::SampleMapper.from_hash(RootAdapters::SampleToSampleMapperAdapter.new(sample).to_h).to_json }
  end

  describe "#to_xml" do
    subject(:to_xml) { sample_presenter.to_xml }

    it { is_expected.to be_a Enumerator }
    it { expect(to_xml.to_a.join).to eq RootMappers::SampleMapper.from_hash(RootAdapters::SampleToSampleMapperAdapter.new(sample).to_h).to_xml }
  end

  describe "#to_csv" do
    subject(:to_csv) { sample_presenter.to_csv }

    it { is_expected.to be_a Enumerator }
    it { expect(to_csv.to_a.join).to eq RootMappers::SampleMapper.from_hash(RootAdapters::SampleToSampleMapperAdapter.new(sample).to_h).to_csv }
  end

  describe "#to_zip" do
    subject(:to_zip) { sample_presenter.to_zip }

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

    context "when sample has minimal attributes" do
      it { is_expected.to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.new("tmp/output").entries.size).to eq 9 }
      it { expect(File.read("tmp/output/data/sample.json")).to eq sample_presenter.to_json.to_a.join }
      it { expect(File.read("tmp/output/data/sample.xml")).to eq sample_presenter.to_xml.to_a.join }
      it { expect(File.read("tmp/output/data/sample.csv")).to eq sample_presenter.to_csv.to_a.join }
    end

    context "when sample has realistic attributes" do
      let(:sample) { create :sample, :with_required_dependencies, :with_realistic_attributes }

      it { is_expected.to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.new("tmp/output").entries.size).to eq 9 }
      it { expect(File.read("tmp/output/data/sample.json")).to eq sample_presenter.to_json.to_a.join }
      it { expect(File.read("tmp/output/data/sample.xml")).to eq sample_presenter.to_xml.to_a.join }
      it { expect(File.read("tmp/output/data/sample.csv")).to eq sample_presenter.to_csv.to_a.join }
    end
  end
end
