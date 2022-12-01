describe SampleMappers::DctConformsToMapper do
  describe ".new" do
    context "when called without any arguments" do
      let(:dct_conforms_to_mapper) { build :dct_conforms_to_mapper }

      it { expect(dct_conforms_to_mapper).to be_a described_class }
      it { expect(dct_conforms_to_mapper).to be_a ShaleCustom::Mapper }
      it { expect(dct_conforms_to_mapper.dct_conformsTo).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :dct_conforms_to_mapper, :with_all_args_nested_structures_as_mappers }
      let(:dct_conforms_to_mapper) { described_class.new(**args) }

      it { expect(dct_conforms_to_mapper).to be_a described_class }
      it { expect(dct_conforms_to_mapper.dct_conformsTo).to eq args[:dct_conformsTo] }
    end
  end

  describe ".from_hash" do
    context "when called without any arguments" do
      let(:dct_conforms_to_mapper) { build :dct_conforms_to_mapper }

      it { expect(dct_conforms_to_mapper).to be_a described_class }
      it { expect(dct_conforms_to_mapper.dct_conformsTo).to be_nil }
    end

    context "when called with_all_args_nested_structures_as_hash" do
      let(:args) { attributes_for(:dct_conforms_to_mapper, :with_all_args_nested_structures_as_hash) }
      let(:dct_conforms_to_mapper) { described_class.from_hash args }

      it { expect(dct_conforms_to_mapper).to be_a described_class }
      it { expect(dct_conforms_to_mapper.dct_conformsTo.as_json).to eq args[:dct_conformsTo].as_json }
      it { expect(dct_conforms_to_mapper.dct_conformsTo).to be_a ReactionMappers::ReagentsList::ItemListElement::DctConformsToElementMapper }
    end
  end

  describe "#to_json" do
    let(:expected_json_nil_render_value) { "null" }

    context "when called without any arguments" do
      let(:dct_conforms_to_mapper) { build :dct_conforms_to_mapper }

      let(:expected_json) do
        <<~JSON
          { "http://purl.org/dc/terms/conformsTo":#{expected_json_nil_render_value} }
        JSON
      end

      it { expect(JSON.parse(dct_conforms_to_mapper.to_json)).to eq JSON.parse(expected_json) }
    end

    context "when called with_all_args_nested_structures_as_hash" do
      let(:args) { attributes_for(:dct_conforms_to_mapper, :with_all_args_nested_structures_as_hash) }
      let(:dct_conforms_to_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          { "http://purl.org/dc/terms/conformsTo":#{ReactionMappers::ReagentsList::ItemListElement::DctConformsToElementMapper.from_hash(args[:dct_conformsTo]).to_json} }
        JSON
      end

      it { expect(JSON.parse(dct_conforms_to_mapper.to_json)).to eq JSON.parse expected_json }
    end
  end
end
