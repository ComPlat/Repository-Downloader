require "dry-files"

describe PublicationsByDoiPresenter do
  describe ".new" do
    subject(:new) { described_class.new [] }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) { publication_by_doi_presenter.to_json }

    let(:publication_by_doi_presenter) { described_class.new dois }

    context "when dois is an empty array" do
      let(:dois) { [] }

      it { expect(to_json.to_a.join).to eq "[]" }
    end

    context "when dois is an array with one doi in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:dois) { [analysis.doi] }

      it { expect(to_json.to_a.join).to eq "[#{analysis.present_to_api.to_json.to_a.join}]" }
    end

    context "when dois is an array with two doi in it" do
      let(:analysis1) { create(:analysis, :with_realistic_attributes) }
      let(:analysis2) do
        create(:analysis, :with_realistic_attributes, taggable_data: {"doi" => analysis1.doi.tr("N", "X"),
                                                                      "analysis_doi" => analysis1.doi.tr("N", "X")})
      end
      let(:dois) { [analysis1.doi, analysis2.doi] }

      let(:expected_json) do
        "[#{analysis1.present_to_api.to_json.to_a.join},#{analysis2.present_to_api.to_json.to_a.join}]"
      end

      it { expect(to_json.to_a.join).to eq expected_json }
    end
  end

  describe "#to_xml" do
    subject(:to_xml) { publication_by_doi_presenter.to_xml }

    let(:publication_by_doi_presenter) { described_class.new dois }

    context "when dois is an empty array" do
      let(:dois) { [] }

      it { expect(to_xml.to_a.join).to eq "<publications></publications>" }
    end

    context "when dois is an array with one doi in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:dois) { [analysis.doi] }

      it { expect(to_xml.to_a.join).to eq "<publications>#{analysis.present_to_api.to_xml.to_a.join}</publications>" }
    end

    context "when dois is an array with two doi in it" do
      let(:analysis1) { create(:analysis, :with_realistic_attributes) }
      let(:analysis2) do
        create(:analysis, :with_realistic_attributes, taggable_data: {"doi" => analysis1.doi.tr("N", "A"),
                                                                      "analysis_doi" => analysis1.doi.tr("N", "A")})
      end
      let(:dois) { [analysis1.doi, analysis2.doi] }

      let(:expected_xml) do
        "<publications>#{analysis1.present_to_api.to_xml.to_a.join}#{analysis2.present_to_api.to_xml.to_a.join}</publications>"
      end

      it { expect(Hash.from_xml(to_xml.to_a.join)).to eq(Hash.from_xml(expected_xml)) }
    end
  end

  describe "#to_zip" do
    subject(:to_zip) { publication_by_doi_presenter.to_zip }

    let(:publication_by_doi_presenter) { described_class.new dois }

    before do
      zip_chunks = []
      to_zip.each { |zip_chunk|
        zip_chunks << zip_chunk
      }

      io = StringIO.new(zip_chunks.join)

      ZipTricks::FileReader.read_zip_structure(io:).each do |entry|
        Dry::Files.new.write "./tmp/output/#{entry.filename}"
        File.open("./tmp/output/#{entry.filename}", "wb") do |extracted_file|
          inflated_reader = entry.extractor_from io
          extracted_file << inflated_reader.extract until inflated_reader.eof?
        end
      end
    end

    after do
      FileUtils.rm_rf "./tmp/output"
    end

    context "when doi is an empty array" do
      let(:dois) { [] }

      it { expect(to_zip).to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 0 }
    end

    context "when doi is an array with one doi in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:dois) { [analysis.doi] }

      it { expect(to_zip).to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 1 }
      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).valid?).to be true }
      it { expect(Dir.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).entries.size).to eq 9 }

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .find { |folder| File.directory?(folder) } + "/data/analysis.json"))
          .to eq publication_by_doi_presenter.to_json.to_a.join
      end

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .find { |folder| File.directory?(folder) } + "/data/analysis.xml"))
          .to eq publication_by_doi_presenter.to_xml.to_a.join
      end
    end

    context "when dois is an array with two doi in it" do
      let(:analysis1) { create(:analysis, :with_realistic_attributes) }
      let(:analysis2) do
        create(:analysis, :with_realistic_attributes, taggable_data: {"doi" => analysis1.doi.tr("N", "A"),
                                                                      "analysis_doi" => analysis1.doi.tr("N", "A")})
      end
      let(:dois) { [analysis1.doi, analysis2.doi] }

      it { expect(to_zip).to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 2 }
      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).valid?).to be true }
      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").select { |folder| File.directory?(folder) }.second).valid?).to be true }
      it { expect(Dir.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).entries.size).to eq 9 }
      it { expect(Dir.new(Dir.glob("./tmp/output/*").select { |folder| File.directory?(folder) }.second).entries.size).to eq 9 }

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .find { |folder| File.directory?(folder) } + "/data/analysis.json"))
          .to eq publication_by_doi_presenter.to_json.to_a.join
      end

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .select { |folder| File.directory?(folder) }.second + "/data/analysis.json"))
          .to eq publication_by_doi_presenter.to_json.to_a.join
      end

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .find { |folder| File.directory?(folder) } + "/data/analysis.xml"))
          .to eq publication_by_doi_presenter.to_xml.to_a.join
      end

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .select { |folder| File.directory?(folder) }.second + "/data/analysis.xml"))
          .to eq publication_by_doi_presenter.to_xml.to_a.join
      end
    end
  end
end
