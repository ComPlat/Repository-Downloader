require "dry-files"

describe PublicationsByDoiPresenter do
  include ZipHelper

  describe ".new" do
    subject(:new) { described_class.new [] }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) do
      json = []
      publication_by_doi_presenter.to_json.each { |chunk| json << chunk }
      json.join
    end

    let(:publication_by_doi_presenter) { described_class.new dois }

    context "when dois is an empty array" do
      let(:dois) { [] }

      let(:expected_json) { "[]" }

      it { expect(to_json).to eq expected_json }
    end

    context "when dois is an array with one doi in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:dois) { [analysis.doi] }

      let(:expected_json) { "[#{analysis.present_to_api.to_json.to_a.first}]" }

      it { expect(to_json).to eq expected_json }
      it { expect(to_json).to be_a String }
    end

    context "when dois is an array with two doi in it" do
      let(:analysis1) { create(:analysis, :with_realistic_attributes) }
      let(:analysis2) do
        create(:analysis, :with_realistic_attributes, taggable_data: {"doi" => analysis1.doi.tr("N", "X"),
                                                                      "analysis_doi" => analysis1.doi.tr("N", "X")})
      end
      let(:dois) { [analysis1.doi, analysis2.doi] }

      let(:expected_json) { "[#{analysis1.present_to_api.to_json.to_a.first},#{analysis2.present_to_api.to_json.to_a.first}]" }

      it { expect(to_json).to eq expected_json }
    end
  end

  describe "#to_xml" do
    subject(:to_xml) do
      xml = []
      publication_by_doi_presenter.to_xml.each { |chunk| xml << chunk }
      xml.join
    end

    let(:publication_by_doi_presenter) { described_class.new dois }

    context "when dois is an empty array" do
      let(:dois) { [] }

      let(:expected_xml) { "<publications></publications>" }

      it { expect(to_xml).to eq expected_xml }
    end

    context "when dois is an array with one doi in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:dois) { [analysis.doi] }

      let(:expected_xml) { "<publications>#{analysis.present_to_api.to_xml.to_a.first}</publications>" }

      it { expect(to_xml).to eq expected_xml }
    end

    context "when dois is an array with two doi in it" do
      let(:analysis1) { create(:analysis, :with_realistic_attributes) }
      let(:analysis2) do
        create(:analysis, :with_realistic_attributes, taggable_data: {"doi" => analysis1.doi.tr("N", "A"),
                                                                      "analysis_doi" => analysis1.doi.tr("N", "A")})
      end
      let(:dois) { [analysis1.doi, analysis2.doi] }

      it do
        expect(Hash.from_xml(to_xml))
          .to eq(Hash.from_xml(
            "<publications>
                           #{analysis1.present_to_api.to_xml.to_a.first}
                           #{analysis2.present_to_api.to_xml.to_a.first}
            </publications>"
          ))
      end
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

      unzip(io: StringIO.new(zip_chunks.join))
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
      it { expect(Dir.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).entries.size).to eq 9 }

      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).valid?).to be true }
      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data").consistent?).to be true }
      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).complete?).to be true }

      it {
        expect(File.read(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/bagit.txt"))
          .to eq "BagIt-Version: 0.97\nTag-File-Character-Encoding: UTF-8\n"
      }

      it { expect(File.exist?(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/manifest-md5.txt")).to be true }

      it {
        expect(File.read(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/manifest-md5.txt").split(" "))
          .to eq [Digest::MD5.file(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/analysis.json").to_s, "data/analysis.json",
            Digest::MD5.file(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/analysis.xml").to_s, "data/analysis.xml"]
      }

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .find { |folder| File.directory?(folder) } + "/data/analysis.json"))
          .to eq analysis.present_to_api.to_json.to_a.join
      end

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .find { |folder| File.directory?(folder) } + "/data/analysis.xml"))
          .to eq analysis.present_to_api.to_xml.to_a.join
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

      it {
        expect(File.read(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/manifest-md5.txt").split(" "))
          .to eq [Digest::MD5.file(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/analysis.json").to_s, "data/analysis.json",
            Digest::MD5.file(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/analysis.xml").to_s, "data/analysis.xml"]
      }

      it {
        expect(File.read(Dir.glob("./tmp/output/*").select { |folder| File.directory?(folder) }.second + "/manifest-md5.txt").split(" "))
          .to eq [Digest::MD5.file(Dir.glob("./tmp/output/*").select { |folder| File.directory?(folder) }.second + "/data/analysis.json").to_s, "data/analysis.json",
            Digest::MD5.file(Dir.glob("./tmp/output/*").select { |folder| File.directory?(folder) }.second + "/data/analysis.xml").to_s, "data/analysis.xml"]
      }

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .find { |folder| File.directory?(folder) } + "/data/analysis.json"))
          .to eq analysis1.present_to_api.to_json.to_a.join
      end

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .select { |folder| File.directory?(folder) }.second + "/data/analysis.json"))
          .to eq analysis2.present_to_api.to_json.to_a.join
      end

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .find { |folder| File.directory?(folder) } + "/data/analysis.xml"))
          .to eq analysis1.present_to_api.to_xml.to_a.join
      end

      it do
        expect(File.read(Dir.glob("./tmp/output/*")
                            .select { |folder| File.directory?(folder) }.second + "/data/analysis.xml"))
          .to eq analysis2.present_to_api.to_xml.to_a.join
      end
    end
  end
end
