require "dry-files"

describe API::V1::Publications, ".analysis" do
  include ZipHelper

  context "when only one request (analysis)" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:analysis_presenter) { AnalysisPresenter.new analysis }

    before do
      get "/api/v1/publications?chemotion_ids=#{analysis.id}&format=zip"

      unzip(io: StringIO.new(response.body))
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

  context "when only one request (reaction)" do
    let(:reaction) { create(:reaction, :with_realistic_attributes) }
    let(:reaction_presenter) { ReactionPresenter.new reaction }

    before do
      get "/api/v1/publications?chemotion_ids=#{reaction.id}&format=zip"

      unzip(io: StringIO.new(response.body))
    end

    after {
      FileUtils.rm_rf "tmp/output"
    }

    it { expect(response).to have_http_status :ok }
    it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 1 }
    it { expect(Dir.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).entries.size).to eq 9 }
    it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).valid?).to be true }

    it do
      expect(File.read(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/reaction.json"))
        .to eq ReactionPresenter.new(reaction).to_json.to_a.join
    end

    it do
      expect(File.read(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/reaction.xml"))
        .to eq ReactionPresenter.new(reaction).to_xml.to_a.join
    end
  end

  context "when only one request (sample)" do
    let(:sample) { create(:sample, :with_realistic_attributes, :with_required_dependencies) }
    let(:sample_presenter) { SamplePresenter.new sample }

    before do
      get "/api/v1/publications?chemotion_ids=#{sample.id}&format=zip"

      unzip(io: StringIO.new(response.body))
    end

    after {
      FileUtils.rm_rf "tmp/output"
    }

    it { expect(response).to have_http_status :ok }
    it { expect(Dir.glob("./tmp/output/*").count { |folder| File.directory?(folder) }).to eq 1 }
    it { expect(Dir.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).entries.size).to eq 9 }
    it { expect(BagIt::Bag.new(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) }).valid?).to be true }

    it do
      expect(File.read(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/sample.json"))
        .to eq SamplePresenter.new(sample).to_json.to_a.join
    end

    it do
      expect(File.read(Dir.glob("./tmp/output/*").find { |folder| File.directory?(folder) } + "/data/sample.xml"))
        .to eq SamplePresenter.new(sample).to_xml.to_a.join
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
