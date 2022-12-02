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
end
