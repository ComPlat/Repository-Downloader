describe ShaleCustom::Types::HashType do
  describe ".cast" do
    subject(:cast) { described_class.cast value }

    context "when value has method as_json" do
      let(:value) { {key: "value"} }

      it { is_expected.to eq value.deep_stringify_keys }
    end

    context "when value has NO method as_json" do
      let(:value) { BasicObject.new }

      it { expect { cast }.to raise_error NoMethodError }
    end

    context "when value is nil" do
      let(:value) { nil }

      it { is_expected.to eq value }
    end
  end
end
