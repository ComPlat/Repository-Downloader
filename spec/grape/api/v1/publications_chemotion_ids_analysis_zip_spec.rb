require "dry-files"

describe API::V1::Publications, ".analysis" do
  context "when only one request" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:analysis_presenter) { AnalysisPresenter.new analysis }

    before do
      get "/api/v1/publications?chemotion_ids=#{analysis.id}&format=zip"

      io = StringIO.new(response.body)

      ZipTricks::FileReader.read_zip_structure(io:).each do |entry|
        Dry::Files.new.write "./tmp/output/#{entry.filename}"
        File.open("tmp/output/#{entry.filename}", "wb") do |extracted_file|
          inflated_reader = entry.extractor_from io
          extracted_file << inflated_reader.extract until inflated_reader.eof?
        end
      end
    end

    after {
      FileUtils.rm_rf "tmp/output"
    }

    it { expect(response).to have_http_status :ok }
    it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 1 }
    it { expect(Dir.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).entries.size).to eq 9 }
    it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).valid?).to be true }

    it do
      expect(File.read(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/analysis.json"))
        .to eq AnalysisPresenter.new(analysis).to_json.to_a.join
    end

    it do
      expect(File.read(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/analysis.xml"))
        .to eq AnalysisPresenter.new(analysis).to_xml.to_a.join
    end
  end

  context "when multiple requests simultaneously" do
    it do
      Parallel.each([1, 2], in_threads: 2) do |_thread_number|
        analysis = create(:analysis, :with_realistic_attributes)
        get "/api/v1/publications?chemotion_ids=#{analysis.id}&format=zip"
        expect(response).to have_http_status :ok
      end
    end
  end
end
