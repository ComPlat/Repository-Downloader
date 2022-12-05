describe SamplePresenter do
  let(:sample) { build :sample }
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

    it { is_expected.to be_a Enumerator }
    it { expect(to_zip.to_a.join).to eq "" }
  end
end
