describe PublicationsByChemotionIdPresenter do
  include ZipHelper

  describe ".new" do
    subject(:new) { described_class.new [] }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) do
      json = []
      publication_by_chemotion_ids_presenter.to_json.each { |chunk| json << chunk }
      json.join
    end

    let(:publication_by_chemotion_ids_presenter) { described_class.new chemotion_ids }

    context "when chemotion_ids is an empty array" do
      let(:chemotion_ids) { [] }
      let(:expected_json) { "[]" }

      it { expect(to_json).to eq expected_json }
    end

    context "when chemotion_ids is an array with one chemotion_id in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:chemotion_ids) { [analysis.id] }

      let(:expected_json) { "[#{analysis.present_to_api.to_json.to_a.first}]" }

      it { expect(to_json).to eq expected_json }
    end

    context "when chemotion_ids is an array with two chemotion_id in it" do
      let(:analysises) { create_list(:analysis, 2, :with_realistic_attributes) }
      let(:chemotion_ids) { [analysises.first.id, analysises.second.id] }

      let(:expected_json) { "[#{analysises.first.present_to_api.to_json.to_a.first},#{analysises.second.present_to_api.to_json.to_a.first}]" }

      it { expect(to_json).to eq expected_json }
    end
  end

  describe "#to_xml" do
    subject(:to_xml) do
      xml = []
      publication_by_chemotion_ids_presenter.to_xml.each { |chunk| xml << chunk }
      xml.join
    end

    let(:publication_by_chemotion_ids_presenter) { described_class.new chemotion_ids }

    context "when chemotion_ids is an empty array" do
      let(:chemotion_ids) { [] }

      it { expect(to_xml).to eq "<publications></publications>" }
    end

    context "when chemotion_ids is an array with one chemotion_id in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:chemotion_ids) { [analysis.id] }

      let(:expected_xml) { "<publications>#{analysis.present_to_api.to_xml.to_a.join}</publications>" }

      it { expect(to_xml).to eq expected_xml }
    end

    context "when chemotion_ids is an array with two chemotion_id in it" do
      let(:analyses) { create_list(:analysis, 2, :with_realistic_attributes) }
      let(:chemotion_ids) { [analyses.first.id, analyses.second.id] }

      let(:expected_xml) { "<publications>#{analyses.first.present_to_api.to_xml.to_a.first}#{analyses.second.present_to_api.to_xml.to_a.first}</publications>" }

      it { expect(to_xml).to eq expected_xml }
    end
  end

  describe "#to_zip" do
    subject(:to_zip) { publication_by_chemotion_ids_presenter.to_zip }

    let(:publication_by_chemotion_ids_presenter) { described_class.new chemotion_ids }

    after do
      FileUtils.rm_rf "./tmp/output"
    end

    context "when chemotion_ids is an empty array" do
      let(:chemotion_ids) { [] }

      before do
        zip_chunks = []
        to_zip.each { |zip_chunk|
          zip_chunks << zip_chunk
        }

        unzip(io: StringIO.new(zip_chunks.join))
      end

      it { expect(to_zip).to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 0 }
    end

    context "when chemotion_ids is an array with one chemotion_id in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:chemotion_ids) { [analysis.id] }

      before do
        zip_chunks = []
        to_zip.each { |zip_chunk|
          zip_chunks << zip_chunk
        }

        unzip(io: StringIO.new(zip_chunks.join))
      end

      it { expect(to_zip).to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 1 }
      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).valid?).to be true }
      it { expect(Dir.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).entries.size).to eq 9 }

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
      let(:analysis2) { create(:analysis, :with_realistic_attributes) }
      let(:chemotion_ids) { [analysis1.id, analysis2.id] }

      before do
        zip_chunks = []
        to_zip.each { |zip_chunk|
          zip_chunks << zip_chunk
        }

        unzip(io: StringIO.new(zip_chunks.join))
      end

      it { expect(to_zip).to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 2 }
      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).valid?).to be true }
      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").select { |folder| File.directory?(folder) }.second).valid?).to be true }
      it { expect(Dir.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).entries.size).to eq 9 }
      it { expect(Dir.new(Dir.glob("./tmp/output/*").select { |folder| File.directory?(folder) }.second).entries.size).to eq 9 }

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

    context "when chemotion_ids is an array with one chemotion_id in it and analysis has one attachment" do
      let(:analysis) { create(:analysis, :with_realistic_attributes, element_id: 1, attachments: [attachment]) }
      let(:attachment) { build(:attachment, :with_realistic_attributes) }
      let(:chemotion_ids) { [analysis.id] }

      before do
        attachment

        FileUtils.mkpath "./files/#{analysis.attachments.first.bucket}"
        FileUtils.cp "./spec/support/cleanercode.png", "./files/#{analysis.attachments.first.bucket}/#{analysis.attachments.first.identifier}"

        zip_chunks = []
        to_zip.each { |zip_chunk|
          zip_chunks << zip_chunk
        }

        unzip(io: StringIO.new(zip_chunks.join))
      end

      after do
        FileUtils.rm_rf "./files/#{analysis.attachments.first.bucket}"
      end

      it { expect(to_zip).to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 1 }
      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).valid?).to be true }
      it { expect(Dir.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).entries.size).to eq 9 }

      it do
        expect(File.size("./files/#{analysis.attachments.first.bucket}/#{analysis.attachments.first.identifier}"))
          .to eq File.size(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/#{attachment.filename}")
      end

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

    context "when chemotion_ids is an array with one chemotion_id in it and analysis has 5 attachments" do
      let(:analysis) { create(:analysis, :with_realistic_attributes, element_id: 1, attachments: attachments.map { |attachment| attachment }) }
      let(:attachments) {
        [build(:attachment, :with_realistic_attributes),
          build(:attachment, :with_realistic_attributes, filename: "JK21-proton.peak.png"),
          build(:attachment, :with_realistic_attributes, filename: "JK22-proton.peak.png"),
          build(:attachment, :with_realistic_attributes, filename: "JK23-proton.peak.png"),
          build(:attachment, :with_realistic_attributes, filename: "JK24-proton.peak.png")]
      }
      let(:chemotion_ids) { [analysis.id] }

      before do
        attachments

        FileUtils.mkpath "./files/#{analysis.attachments.first.bucket}"
        FileUtils.cp "./spec/support/cleanercode.png", "./files/#{analysis.attachments.first.bucket}/#{analysis.attachments.first.identifier}"

        zip_chunks = []
        to_zip.each { |zip_chunk|
          zip_chunks << zip_chunk
        }

        unzip(io: StringIO.new(zip_chunks.join))
      end

      after do
        FileUtils.rm_rf "./files/#{analysis.attachments.first.bucket}"
      end

      it { expect(to_zip).to be_a ZipTricks::OutputEnumerator }
      it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 1 }
      it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).valid?).to be true }
      it { expect(Dir.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).entries.size).to eq 9 }

      it do
        expect(File.size("./files/#{analysis.attachments.first.bucket}/#{analysis.attachments.first.identifier}"))
          .to eq File.size(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/#{attachments.first.filename}")
      end

      it do
        expect(File.size("./files/#{analysis.attachments.first.bucket}/#{analysis.attachments.first.identifier}"))
          .to eq File.size(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/#{attachments.second.filename}")
      end

      it do
        expect(File.size("./files/#{analysis.attachments.first.bucket}/#{analysis.attachments.first.identifier}"))
          .to eq File.size(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/#{attachments[2].filename}")
      end

      it do
        expect(File.size("./files/#{analysis.attachments.first.bucket}/#{analysis.attachments.first.identifier}"))
          .to eq File.size(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/#{attachments[3].filename}")
      end

      it do
        expect(File.size("./files/#{analysis.attachments.first.bucket}/#{analysis.attachments.first.identifier}"))
          .to eq File.size(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/#{attachments[4].filename}")
      end

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
  end
end
