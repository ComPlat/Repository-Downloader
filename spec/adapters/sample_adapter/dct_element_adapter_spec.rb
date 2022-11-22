describe SampleAdapter::DctElementAdapter do
  let(:dct_element_adapter) { described_class.new }

  describe ".new" do
    it { is_expected.to be_a described_class }
  end

  describe "#id" do
    subject { described_class.id }

    it { is_expected.to eq "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE" }
    it { is_expected.to be_a String }
  end

  describe "#type" do
    subject { described_class.type }

    it { is_expected.to eq "CreativeWork" }
    it { is_expected.to be_a String }
  end
end
