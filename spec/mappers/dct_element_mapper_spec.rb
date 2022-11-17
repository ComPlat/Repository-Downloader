describe DctElementMapper do
  # TODO: Write tests for it!
  let(:expected_json_nil_render_value) { "null" }

  describe ".new" do
    context "when called without any arguments" do
      let(:dct_element_mapper) { build :dct_element_mapper }

      it { expect(dct_element_mapper).to be_a described_class }
      it { expect(dct_element_mapper).to be_a ShaleCustom::Mapper }
      it { expect(dct_element_mapper.conformsTo).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :dct_element_mapper, :with_all_args_nested_structures_as_mappers }
      let(:dct_element_mapper) { described_class.new(**args) }

      it { expect(dct_element_mapper).to be_a described_class }
      it { expect(dct_element_mapper.conformsTo).to eq args[:conformsTo] }
    end
  end

  describe ".from_hash" do
    context "when called without any arguments" do
      let(:dct_element_mapper) { build :dct_element_mapper }

      it { expect(dct_element_mapper).to be_a described_class }
      it { expect(dct_element_mapper.conformsTo).to be_nil }
    end

    context "when called with_all_args_nested_structures_as_hash" do
      let(:args) { attributes_for(:dct_element_mapper, :with_all_args_nested_structures_as_hash) }
      let(:dct_element_mapper) { described_class.from_hash args }

      it { expect(dct_element_mapper).to be_a described_class }
      it { expect(dct_element_mapper.conformsTo.as_json).to eq args[:conformsTo].as_json }
      it { expect(dct_element_mapper.conformsTo).to all be_a DctListMapper }
    end
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:dct_element_mapper) { build :dct_element_mapper }

      let(:expected_json) do
        <<~JSON
          {
            "http://purl.org/dc/terms/conformsTo":#{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(JSON.parse(dct_element_mapper.to_json)).to eq JSON.parse(expected_json) }
    end

    context "when called with_all_args_nested_structures_as_hash" do
      let(:args) { attributes_for(:dct_element_mapper, :with_all_args_nested_structures_as_hash) }
      let(:dct_element_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "http://purl.org/dc/terms/conformsTo":#{args[:conformsTo].as_json}
          }
        JSON
      end

      it { expect(dct_element_mapper.to_json).to eq expected_json }
    end
  end
end
