describe SampleAdapter::MolecularWeightAdapter do
  let(:sample) { build :sample, :with_required_dependencies, :with_realistic_attributes }
  let(:molecular_weight_adapter) { described_class.new sample }

  describe ".new" do
    subject { molecular_weight_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { molecular_weight_adapter.to_h }

    it { is_expected.to include({value: molecular_weight_adapter.value}) }
  end

  describe "#value" do
    subject { molecular_weight_adapter.value }

    it { is_expected.to eq sample.molecular_weight }
    it { is_expected.to be_a Float }
  end
end
