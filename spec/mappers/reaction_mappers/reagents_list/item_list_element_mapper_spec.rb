describe ReactionMappers::ReagentsList::ItemListElementMapper do
  let(:expected_json_nil_render_value) { "null" }
  let(:reagents_list_item_list_element_mapper) { build :reagents_list_item_list_element_mapper, :with_all_args }

  context "when called without any arguments" do
    let(:reagents_list_item_list_element_mapper) { build :reagents_list_item_list_element_mapper }

    it { expect(reagents_list_item_list_element_mapper).to be_a described_class }
    it { expect(reagents_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(reagents_list_item_list_element_mapper.type).to be_nil }
    it { expect(reagents_list_item_list_element_mapper.dct_conformsTo).to eq [] }
    it { expect(reagents_list_item_list_element_mapper.id).to be_nil }
    it { expect(reagents_list_item_list_element_mapper.identifier).to be_nil }
    it { expect(reagents_list_item_list_element_mapper.name).to be_nil }
    it { expect(reagents_list_item_list_element_mapper.molecularFormula).to be_nil }
    it { expect(reagents_list_item_list_element_mapper.inChIKey).to be_nil }
    it { expect(reagents_list_item_list_element_mapper.smiles).to be_nil }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "@type": #{expected_json_nil_render_value},
            "dct:conformsTo": [],
            "@id": #{expected_json_nil_render_value},
            "identifier": #{expected_json_nil_render_value},
            "name": #{expected_json_nil_render_value},
            "molecularFormula": #{expected_json_nil_render_value},
            "inChIKey": #{expected_json_nil_render_value},
            "smiles": #{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(reagents_list_item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  context "when called with all arguments" do
    let(:args) { attributes_for :reagents_list_item_list_element_mapper, :with_all_args }
    let(:reagents_list_item_list_element_mapper) { described_class.new(**args) }
    let(:dct_list_mapper) { build :dct_list_mapper, :with_all_args }

    it { expect(reagents_list_item_list_element_mapper).to be_a described_class }
    it { expect(reagents_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(reagents_list_item_list_element_mapper.type).to eq args[:type] }
    it { expect(reagents_list_item_list_element_mapper.dct_conformsTo).to eq args[:dct_conformsTo] }
    it { expect(reagents_list_item_list_element_mapper.id).to eq args[:id] }
    it { expect(reagents_list_item_list_element_mapper.identifier).to eq args[:identifier] }
    it { expect(reagents_list_item_list_element_mapper.name).to eq args[:name] }
    it { expect(reagents_list_item_list_element_mapper.molecularFormula).to eq args[:molecularFormula] }
    it { expect(reagents_list_item_list_element_mapper.inChIKey).to eq args[:inChIKey] }
    it { expect(reagents_list_item_list_element_mapper.smiles).to eq args[:smiles] }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "@type": "#{args[:type]}",
            "dct:conformsTo": [{"@type": "#{dct_list_mapper.type}", "@id": "#{dct_list_mapper.id}"}],
            "@id": "#{args[:id]}",
            "identifier": "#{args[:identifier]}",
            "name": "#{args[:name]}",
            "molecularFormula": "#{args[:molecularFormula]}",
            "inChIKey": "#{args[:inChIKey]}",
            "smiles": "#{args[:smiles]}"
          }
        JSON
      end

      it { expect(reagents_list_item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  context "when called with some arguments" do
    let(:args) { attributes_for :reagents_list_item_list_element_mapper, :with_all_args, type: nil, id: nil, molecularFormula: nil }
    let(:reagents_list_item_list_element_mapper) { described_class.new(**args) }
    let(:dct_list_mapper) { build :dct_list_mapper, :with_all_args }

    it { expect(reagents_list_item_list_element_mapper).to be_a described_class }
    it { expect(reagents_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(reagents_list_item_list_element_mapper.type).to be_nil }
    it { expect(reagents_list_item_list_element_mapper.dct_conformsTo).to eq args[:dct_conformsTo] }
    it { expect(reagents_list_item_list_element_mapper.id).to be_nil }
    it { expect(reagents_list_item_list_element_mapper.identifier).to eq args[:identifier] }
    it { expect(reagents_list_item_list_element_mapper.name).to eq args[:name] }
    it { expect(reagents_list_item_list_element_mapper.molecularFormula).to be_nil }
    it { expect(reagents_list_item_list_element_mapper.inChIKey).to eq args[:inChIKey] }
    it { expect(reagents_list_item_list_element_mapper.smiles).to eq args[:smiles] }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "@type": #{expected_json_nil_render_value},
            "dct:conformsTo": [{"@type": "#{dct_list_mapper.type}", "@id": "#{dct_list_mapper.id}"}],
            "@id": #{expected_json_nil_render_value},
            "identifier": "#{args[:identifier]}",
            "name": "#{args[:name]}",
            "molecularFormula": #{expected_json_nil_render_value},
            "inChIKey": "#{args[:inChIKey]}",
            "smiles": "#{args[:smiles]}"
          }
        JSON
      end

      it { expect(reagents_list_item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
