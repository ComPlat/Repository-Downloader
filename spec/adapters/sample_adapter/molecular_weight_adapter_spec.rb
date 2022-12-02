describe SampleAdapter::MolecularWeightAdapter do
  let(:sample) { build :sample, :with_required_dependencies, :with_realistic_attributes }
  let(:molecular_weight_adapter) { described_class.new sample }

  describe ".new" do
    subject { molecular_weight_adapter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_h" do
    subject { molecular_weight_adapter.to_h }

    context "when molecular_weight is correctly filled" do
      it { is_expected.to include({value: molecular_weight_adapter.value}) }
    end

    context "when molecular_weight is nil" do
      let(:sample) { build :sample, :with_required_dependencies, :with_realistic_attributes, molecular_weight: nil }

      let(:expected_hash) { {value: nil} }

      it { is_expected.to eq expected_hash }
    end
  end

  describe "#value" do
    subject { molecular_weight_adapter.value }

    context "when molecular_weight is correctly filled" do
      it { is_expected.to eq sample.molecular_weight }
      it { is_expected.to be_a Float }
    end

    context "when molecular_weight is nil" do
      let(:sample) { build :sample, :with_required_dependencies, :with_realistic_attributes, molecular_weight: nil }

      it { is_expected.to eq sample.molecular_weight }
      it { is_expected.to be_nil }
    end
  end
end
