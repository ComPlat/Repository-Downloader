describe SampleAdapter::DctConformsToElementAdapter do
  let(:dct_element_adapter) { described_class.new }

  describe ".new" do
    subject(:new) { dct_element_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { dct_element_adapter.to_h }

    it { is_expected.to eq(id: dct_element_adapter.id, type: dct_element_adapter.type) }
  end

  describe "#id" do
    subject { dct_element_adapter.id }

    it { is_expected.to eq described_class::ID }
  end

  describe "#type" do
    subject { dct_element_adapter.type }

    it { is_expected.to eq described_class::TYPE }
  end
end
