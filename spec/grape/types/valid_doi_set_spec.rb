describe Types::ValidDoiSet do
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

    context "when value is {valid_doi1},{invalid_doi1}" do
      let(:valid_doi1) { "10.14272/JCKOUAWEMPKIAT-OBKDMQGPSA-N" }
      let(:invalid_doi1) { "invalid_doi_format" }
      let(:value) { "#{valid_doi1},#{invalid_doi1}" }

      it { is_expected.to be_a Grape::Types::InvalidValue }
    end

    context "when value is {valid_doi1},{valid_doi1}" do
      let(:valid_doi1) { "10.14272/JCKOUAWEMPKIAT-OBKDMQGPSA-N" }
      let(:value) { "#{valid_doi1},#{valid_doi1}" }

      it { is_expected.to be_a Grape::Types::InvalidValue }
    end

    context "when value is {valid_doi1},{valid_doi2}" do
      let(:valid_doi1) { "10.14272/JCKOUAWEMPKIAT-OBKDMQGPSA-N" }
      let(:valid_doi2) { "10.14272/CSNXIDADBPPXAP-UHFFFAOYSA-N.2" }
      let(:value) { "#{valid_doi1},#{valid_doi2}" }

      it { is_expected.to be_a described_class }
      it { expect(parse.value).to eq [valid_doi1, valid_doi2] }
    end
  end
end
