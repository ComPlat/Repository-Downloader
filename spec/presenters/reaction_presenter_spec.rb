require "dry-files"

describe ReactionPresenter do
  let(:reaction) { create(:reaction, :with_realistic_attributes) }
  let(:reaction_presenter) { described_class.new reaction }

  describe ".new" do
    subject(:new) { reaction_presenter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) { reaction_presenter.to_json }

    it { is_expected.to be_a Enumerator }
    it { expect(to_json.to_a.join).to eq RootMappers::ReactionMapper.from_hash(RootAdapters::ReactionToReactionMapperAdapter.new(reaction).to_h).to_json }
  end

  describe "#to_xml" do
    subject(:to_xml) { reaction_presenter.to_xml }

    it { is_expected.to be_a Enumerator }
    it { expect(to_xml.to_a.join).to eq RootMappers::ReactionMapper.from_hash(RootAdapters::ReactionToReactionMapperAdapter.new(reaction).to_h).to_xml }
  end

  describe "#to_csv" do
    subject(:to_csv) { reaction_presenter.to_csv }

    it { is_expected.to be_a Enumerator }
    it { expect(to_csv.to_a.join).to eq RootMappers::ReactionMapper.from_hash(RootAdapters::ReactionToReactionMapperAdapter.new(reaction).to_h).to_csv }
  end

  describe "#to_zip" do
    subject(:to_zip) { reaction_presenter.to_zip }

    before do
      zip_chunks = []
      to_zip.each { |zip_chunk|
        zip_chunks << zip_chunk
      }

      io = StringIO.new(zip_chunks.join)

      ZipTricks::FileReader.read_zip_structure(io:).each do |entry|
        Dry::Files.new.touch "./tmp/output/#{entry.filename}"
        File.open("tmp/output/#{entry.filename}", "wb") do |extracted_file|
          inflated_reader = entry.extractor_from io
          extracted_file << inflated_reader.extract until inflated_reader.eof?
        end
      end
    end

    after do
      FileUtils.rm_rf "tmp/output"
    end

    it "returns an OutputEnumerator" do
      expect(to_zip).to be_a ZipTricks::OutputEnumerator
    end
  end
end
