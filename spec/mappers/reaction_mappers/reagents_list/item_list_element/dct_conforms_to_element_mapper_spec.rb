describe ReactionMappers::ReagentsList::ItemListElement::DctConformsToElementMapper do
  describe ".new" do
    context "when called without any arguments" do
      let(:dct_conforms_to_element_mapper) { build :dct_conforms_to_element_mapper }

      it { expect(dct_conforms_to_element_mapper).to be_a described_class }
      it { expect(dct_conforms_to_element_mapper).to be_a ShaleCustom::Mapper }
      it { expect(dct_conforms_to_element_mapper.type).to be_nil }
      it { expect(dct_conforms_to_element_mapper.id).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :dct_conforms_to_element_mapper, :with_all_args }
      let(:dct_conforms_to_element_mapper) { described_class.new(**args) }

      it { expect(dct_conforms_to_element_mapper).to be_a described_class }
      it { expect(dct_conforms_to_element_mapper).to be_a ShaleCustom::Mapper }
      it { expect(dct_conforms_to_element_mapper.type).to eq args[:type] }
      it { expect(dct_conforms_to_element_mapper.id).to eq args[:id] }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for :dct_conforms_to_element_mapper, :with_all_args, type: nil }
      let(:dct_conforms_to_element_mapper) { described_class.new(**args) }

      it { expect(dct_conforms_to_element_mapper).to be_a described_class }
      it { expect(dct_conforms_to_element_mapper).to be_a ShaleCustom::Mapper }
      it { expect(dct_conforms_to_element_mapper.type).to be_nil }
      it { expect(dct_conforms_to_element_mapper.id).to eq args[:id] }
    end
  end

  describe "to_json" do
    let(:expected_json_nil_render_value) { "null" }

    context "when called without any arguments" do
      let(:dct_conforms_to_element_mapper) { build :dct_conforms_to_element_mapper }

      let(:expected_json) do
        <<~JSON
          {
            "@type": #{expected_json_nil_render_value},
            "@id": #{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(dct_conforms_to_element_mapper.to_json).to eq_without_whitespace expected_json }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :dct_conforms_to_element_mapper, :with_all_args }
      let(:dct_conforms_to_element_mapper) { described_class.new(**args) }

      let(:expected_json) do
        <<~JSON
          {
            "@type": "#{args[:type]}",
            "@id": "#{args[:id]}"
          }
        JSON
      end

      it { expect(dct_conforms_to_element_mapper.to_json).to eq_without_whitespace expected_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for :dct_conforms_to_element_mapper, :with_all_args, type: nil }
      let(:dct_conforms_to_element_mapper) { described_class.new(**args) }

      let(:expected_json) do
        <<~JSON
          {
            "@type": #{expected_json_nil_render_value},
            "@id": "#{args[:id]}"
          }
        JSON
      end

      it { expect(dct_conforms_to_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
