describe Types::ValidListOfSearchOperators do
  let(:valid_search_operators) { %w[EQUAL LIKE] }

  describe ".parse" do
    subject(:parse) { described_class.parse(value) }

    context "when value is empty string" do
      let(:value) { "" }

      it { is_expected.to be_a Grape::Types::InvalidValue }
      it { expect(subject.instance_values["message"]).to eq "No empty input allowed." }
    end

    context "when value is list of empty strings" do
      let(:value) { "\t\t\t" }

      it { is_expected.to be_a Grape::Types::InvalidValue }
      it { expect(subject.instance_values["message"]).to eq "No empty input allowed." }
    end

    context "when value is an invalid search operator" do
      let(:value) { "INVALID" }

      it { is_expected.to be_a Grape::Types::InvalidValue }
      it { expect(subject.instance_values["message"]).to eq "Only allowed values are 'EQUAL' and 'LIKE'" }
    end

    context "when value is a single valid search operator" do
      let(:value) { valid_search_operators.first }

      it { expect(parse.value).to eq [value] }
    end

    context "when value is a single other valid search operator" do
      let(:value) { valid_search_operators.second }

      it { expect(parse.value).to eq [value] }
    end

    context "when value is {valid_search_operator},{invalid_search_operator}" do
      let(:invalid_search_operator) { "INVALID" }
      let(:value) { "#{valid_search_operators.first}\t#{invalid_search_operator}" }

      it { is_expected.to be_a Grape::Types::InvalidValue }
      it { expect(subject.instance_values["message"]).to eq "Only allowed values are 'EQUAL' and 'LIKE'" }
    end

    context "when value is {valid_search_operator1},{valid_search_operator2}" do
      let(:value) { "#{valid_search_operators.first}\t#{valid_search_operators.second}" }

      it { expect(parse.value).to eq [valid_search_operators.first, valid_search_operators.second] }
    end
  end
end
