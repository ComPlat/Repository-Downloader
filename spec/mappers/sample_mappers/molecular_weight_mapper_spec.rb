describe SampleMappers::MolecularWeightMapper do
  let(:expected_json_nil_render_value) { "null" }

  describe ".new" do
    context "when called without any arguments" do
      let(:molecular_weight_mapper) { build :molecular_weight_mapper }

      it { expect(molecular_weight_mapper).to be_a described_class }
      it { expect(molecular_weight_mapper).to be_a ShaleCustom::Mapper }
      it { expect(molecular_weight_mapper.value).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :molecular_weight_mapper, :with_all_args }
      let(:molecular_weight_mapper) { described_class.new(**args) }

      it { expect(molecular_weight_mapper).to be_a described_class }
      it { expect(molecular_weight_mapper).to be_a ShaleCustom::Mapper }
      it { expect(molecular_weight_mapper.value).to eq args[:value] }
    end
  end

  describe ".from_hash" do
    context "when called without any arguments" do
      let(:molecular_weight_mapper) { build :molecular_weight_mapper }

      it { expect(molecular_weight_mapper).to be_a described_class }
      it { expect(molecular_weight_mapper.value).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:molecular_weight_mapper, :with_all_args) }
      let(:molecular_weight_mapper) { described_class.from_hash args }

      it { expect(molecular_weight_mapper).to be_a described_class }
      it { expect(molecular_weight_mapper.value).to eq args[:value] }
    end
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:molecular_weight_mapper) { build :molecular_weight_mapper }

      let(:expected_json) do
        <<~JSON
          {
            "value": #{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(molecular_weight_mapper.to_json).to eq_without_whitespace expected_json }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:molecular_weight_mapper, :with_all_args) }
      let(:molecular_weight_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "value": #{args[:value]}
          }
        JSON
      end

      it { expect(molecular_weight_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
