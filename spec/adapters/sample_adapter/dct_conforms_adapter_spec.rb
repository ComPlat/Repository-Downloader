describe SampleAdapter::DctConformsAdapter do
  let(:dct_conforms_adapter) { described_class.new }

  describe ".new" do
    subject { dct_conforms_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { dct_conforms_adapter.to_h }

    let(:url) { SampleAdapter::DctConformsAdapter::CONFORMS_URL }
    let(:id) { SampleAdapter::DctElementAdapter::ID }
    let(:type) { SampleAdapter::DctElementAdapter::TYPE }

    it { is_expected.to eq({url => {id: id, type: type}}) }
  end
end
