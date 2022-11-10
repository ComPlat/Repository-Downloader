describe ItemListElementMapper do
  let(:expected_json_nil_render_value) { "null" }

  context "when called without any arguments" do
    let(:item_list_element_mapper) { build :item_list_element_mapper }

    it { expect(item_list_element_mapper).to be_a described_class }
    it { expect(item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(item_list_element_mapper.type).to be_nil }
    it { expect(item_list_element_mapper.identifier).to be_nil }
    it { expect(item_list_element_mapper.filename).to be_nil }
    it { expect(item_list_element_mapper.filepath).to be_nil }
    it { expect(item_list_element_mapper.name).to be_nil }
    it { expect(item_list_element_mapper.Instrument).to be_nil }
    it { expect(item_list_element_mapper.descriptions).to be_nil }
    # it { expect(item_list_element_mapper.attachmentList).to be_nil }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "type": #{expected_json_nil_render_value},
            "identifier": #{expected_json_nil_render_value},
            "filename": #{expected_json_nil_render_value},
            "filepath": #{expected_json_nil_render_value},
            "name": #{expected_json_nil_render_value},
            "Instrument": #{expected_json_nil_render_value},
            "descriptions": #{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  context "when called with all arguments" do
    let(:args) { attributes_for :item_list_element_mapper, :with_all_args }
    let(:item_list_element_mapper) { described_class.new(**args) }

    it { expect(item_list_element_mapper).to be_a described_class }
    it { expect(item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(item_list_element_mapper.type).to eq args[:type] }
    it { expect(item_list_element_mapper.identifier).to eq args[:identifier] }
    it { expect(item_list_element_mapper.filename).to eq args[:filename] }
    it { expect(item_list_element_mapper.filepath).to eq args[:filepath] }
    it { expect(item_list_element_mapper.name).to eq args[:name] }
    it { expect(item_list_element_mapper.Instrument).to eq args[:Instrument] }
    it { expect(item_list_element_mapper.descriptions).to eq args[:descriptions] }
    # it { expect(item_list_element_mapper.attachmentList).to eq args[:numberOfItems] }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "type": "#{args[:type]}",
            "identifier": "#{args[:identifier]}",
            "filename": "#{args[:filename]}",
            "filepath": "#{args[:filepath]}",
            "name": "#{args[:name]}",
            "Instrument": "#{args[:Instrument]}",
            "descriptions": "#{args[:descriptions]}"
          }
        JSON
      end

      it { expect(item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  context "when called some arguments" do
    let(:args) { attributes_for :item_list_element_mapper, :with_all_args, identifier: nil, filepath: nil, Instrument: nil }
    let(:item_list_element_mapper) { described_class.new(**args) }

    it { expect(item_list_element_mapper).to be_a described_class }
    it { expect(item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(item_list_element_mapper.type).to eq args[:type] }
    it { expect(item_list_element_mapper.identifier).to be_nil }
    it { expect(item_list_element_mapper.filename).to eq args[:filename] }
    it { expect(item_list_element_mapper.filepath).to be_nil }
    it { expect(item_list_element_mapper.name).to eq args[:name] }
    it { expect(item_list_element_mapper.Instrument).to be_nil }
    it { expect(item_list_element_mapper.descriptions).to eq args[:descriptions] }
    # it { expect(item_list_element_mapper.attachmentList).to eq args[:numberOfItems] }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "type": "#{args[:type]}",
            "identifier": #{expected_json_nil_render_value},
            "filename": "#{args[:filename]}",
            "filepath": #{expected_json_nil_render_value},
            "name": "#{args[:name]}",
            "Instrument": #{expected_json_nil_render_value},
            "descriptions": "#{args[:descriptions]}"
          }
        JSON
      end

      it { expect(item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
