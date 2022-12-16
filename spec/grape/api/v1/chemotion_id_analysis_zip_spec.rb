describe API::V1::Publications::ChemotionId, ".analysis" do
  context "when only one request" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:analysis_presenter) { AnalysisPresenter.new analysis }

    before do
      get "/api/v1/publications/chemotion_id/#{analysis.id}.zip"

      FileUtils.mkpath "tmp/output/data"

      io = StringIO.new(response.body)

      ZipTricks::FileReader.read_zip_structure(io:).each do |entry|
        File.open("tmp/output/#{entry.filename}", "wb") do |extracted_file|
          inflated_reader = entry.extractor_from io
          extracted_file << inflated_reader.extract until inflated_reader.eof?
        end
      end
    end

    after {
      FileUtils.rm_rf "tmp/bagit"
      FileUtils.rm_rf "tmp/output"
    }

    it { expect(response).to have_http_status :ok }
    it { expect(Dir.new("tmp/output").entries.size).to eq 9 }
    it { expect(File.read("tmp/output/data/analysis.json")).to eq analysis_presenter.to_json.to_a.join }
    it { expect(File.read("tmp/output/data/analysis.xml")).to eq analysis_presenter.to_xml.to_a.join }
    it { expect(File.read("tmp/output/data/analysis.csv")).to eq analysis_presenter.to_csv.to_a.join }
    it { expect(BagIt::Bag.new("tmp/output").valid?).to be true }
  end

  context "when multiple requests simultaneously" do
    it do
      Parallel.each([1, 2], in_threads: 2) do |_thread_number|
        analysis = create(:analysis, :with_realistic_attributes)
        get "/api/v1/publications/chemotion_id/#{analysis.id}.zip"
        expect(response).to have_http_status :ok
      end
    end
  end
end
