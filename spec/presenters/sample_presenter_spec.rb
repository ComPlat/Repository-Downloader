describe SamplePresenter do
  let(:sample) { build :sample }
  let(:sample_presenter) { described_class.new sample }

  describe ".new" do
    subject(:new) { sample_presenter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject { sample_presenter.to_json }

    it { is_expected.to eq RootMappers::SampleMapper.from_hash(RootAdapters::SampleToSampleMapperAdapter.new(sample).to_h).to_json }
  end

  describe "#to_xml" do
    subject { sample_presenter.to_xml }

    it { is_expected.to eq RootMappers::SampleMapper.from_hash(RootAdapters::SampleToSampleMapperAdapter.new(sample).to_h).to_xml }
  end

  describe "#to_csv" do
    subject { sample_presenter.to_csv }

    it { is_expected.to eq RootMappers::SampleMapper.from_hash(RootAdapters::SampleToSampleMapperAdapter.new(sample).to_h).to_csv }
  end

  describe "#to_zip" do
    subject { sample_presenter.to_zip }

    it { is_expected.to be_nil }
  end
end
