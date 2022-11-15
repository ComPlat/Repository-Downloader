describe DataSetListItemListElementMapper do
  let(:expected_json_nil_render_value) { "null" }
  let(:attachment_list_mapper) { build :attachment_list_mapper, :with_all_args }

  context "when called without any arguments" do
    let(:data_set_list_item_list_element_mapper) { build :data_set_list_item_list_element_mapper }

    it { expect(data_set_list_item_list_element_mapper).to be_a described_class }
    it { expect(data_set_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(data_set_list_item_list_element_mapper.type).to be_nil }
    it { expect(data_set_list_item_list_element_mapper.identifier).to be_nil }
    it { expect(data_set_list_item_list_element_mapper.name).to be_nil }
    it { expect(data_set_list_item_list_element_mapper.Instrument).to be_nil }
    it { expect(data_set_list_item_list_element_mapper.descriptions).to be_nil }
    it { expect(data_set_list_item_list_element_mapper.attachmentList).to be_nil }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "@type": #{expected_json_nil_render_value},
            "identifier": #{expected_json_nil_render_value},
            "name": #{expected_json_nil_render_value},
            "Instrument": #{expected_json_nil_render_value},
            "descriptions": #{expected_json_nil_render_value},
            "attachmentList": #{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(data_set_list_item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  context "when called with all arguments" do
    let(:args) { attributes_for :data_set_list_item_list_element_mapper, :with_all_args }
    let(:data_set_list_item_list_element_mapper) { described_class.new(**args) }

    it { expect(data_set_list_item_list_element_mapper).to be_a described_class }
    it { expect(data_set_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(data_set_list_item_list_element_mapper.type).to eq args[:type] }
    it { expect(data_set_list_item_list_element_mapper.identifier).to eq args[:identifier] }
    it { expect(data_set_list_item_list_element_mapper.name).to eq args[:name] }
    it { expect(data_set_list_item_list_element_mapper.Instrument).to eq args[:Instrument] }
    it { expect(data_set_list_item_list_element_mapper.descriptions).to eq args[:descriptions] }
    it { expect(data_set_list_item_list_element_mapper.attachmentList).to eq args[:attachmentList] }
    it { expect(data_set_list_item_list_element_mapper.attachmentList.to_json).to eq_without_whitespace attachment_list_mapper.to_json }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "@type":"#{args[:type]}",
            "identifier":"#{args[:identifier]}",
            "name":"#{args[:name]}",
            "Instrument":"#{args[:Instrument]}",
            "descriptions":"#{args[:descriptions]}",
            "attachmentList":#{attachment_list_mapper.to_json}
          }
        JSON
      end

      it { expect(data_set_list_item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  context "when called some arguments" do
    let(:args) { attributes_for :data_set_list_item_list_element_mapper, :with_all_args, identifier: nil, Instrument: nil }
    let(:data_set_list_item_list_element_mapper) { described_class.new(**args) }

    it { expect(data_set_list_item_list_element_mapper).to be_a described_class }
    it { expect(data_set_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(data_set_list_item_list_element_mapper.type).to eq args[:type] }
    it { expect(data_set_list_item_list_element_mapper.identifier).to be_nil }
    it { expect(data_set_list_item_list_element_mapper.name).to eq args[:name] }
    it { expect(data_set_list_item_list_element_mapper.Instrument).to be_nil }
    it { expect(data_set_list_item_list_element_mapper.descriptions).to eq args[:descriptions] }
    it { expect(data_set_list_item_list_element_mapper.attachmentList).to eq args[:attachmentList] }
    it { expect(data_set_list_item_list_element_mapper.attachmentList.to_json).to eq_without_whitespace attachment_list_mapper.to_json }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "@type":"#{args[:type]}",
            "identifier":#{expected_json_nil_render_value},
            "name":"#{args[:name]}",
            "Instrument":#{expected_json_nil_render_value},
            "descriptions":"#{args[:descriptions]}",
            "attachmentList":#{attachment_list_mapper.to_json}
          }
        JSON
      end

      it {
        expect(data_set_list_item_list_element_mapper.to_json).to eq_without_whitespace expected_json
      }
    end
  end
end