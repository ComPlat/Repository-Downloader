describe SampleAdapter::DctConformsAdapter do
  let(:dct_conforms_adapter) { described_class.new }

  describe ".new" do
    subject { dct_conforms_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { dct_conforms_adapter.to_h }

    it { is_expected.to eq({described_class::CONFORMS_URL => SampleAdapter::DctElementAdapter.new.to_h}) }
  end
end
