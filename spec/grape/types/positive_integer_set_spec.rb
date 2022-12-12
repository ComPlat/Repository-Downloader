describe Types::PositiveIntegerSet do
  describe ".parse" do
    subject(:parse) { described_class.parse(value) }

    context "when value is empty string" do
      let(:value) { "" }

      it { is_expected.to be_a Grape::Types::InvalidValue }
    end

    context "when value is list of empty strings" do
      let(:value) { ",,," }

      it { is_expected.to be_a Grape::Types::InvalidValue }
    end

    context "when value is 1,A" do
      let(:value) { "1,A" }

      it { is_expected.to be_a Grape::Types::InvalidValue }
    end

    context "when value is 1,-1" do
      let(:value) { "1,-1" }

      it { is_expected.to be_a Grape::Types::InvalidValue }
    end

    context "when value is 1,1" do
      let(:value) { "1,1" }

      it { is_expected.to be_a Grape::Types::InvalidValue }
    end

    context "when value is 1,2" do
      let(:value) { "1,2" }

      it { is_expected.to be_a described_class }
      it { expect(parse.value).to eq [1, 2] }
    end
  end
end
