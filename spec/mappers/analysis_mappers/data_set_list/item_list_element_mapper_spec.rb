describe AnalysisMappers::DataSetList::ItemListElementMapper do
  let(:expected_json_nil_render_value) { "null" }

  describe ".new" do
    context "when called without any arguments" do
      let(:data_set_list_item_list_element_mapper) { build(:data_set_list_item_list_element_mapper) }

      it { expect(data_set_list_item_list_element_mapper).to be_a described_class }
      it { expect(data_set_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
      it { expect(data_set_list_item_list_element_mapper.type).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.identifier).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.name).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.Instrument).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.descriptions).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.attachmentList).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_mappers) }
      let(:data_set_list_item_list_element_mapper) { described_class.new(**args) }

      it { expect(data_set_list_item_list_element_mapper).to be_a described_class }
      it { expect(data_set_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
      it { expect(data_set_list_item_list_element_mapper.type).to eq args[:type] }
      it { expect(data_set_list_item_list_element_mapper.identifier).to eq args[:identifier] }
      it { expect(data_set_list_item_list_element_mapper.name).to eq args[:name] }
      it { expect(data_set_list_item_list_element_mapper.Instrument).to eq args[:Instrument] }
      it { expect(data_set_list_item_list_element_mapper.descriptions).to eq args[:descriptions] }
      it { expect(data_set_list_item_list_element_mapper.attachmentList).to eq args[:attachmentList] }
    end

    context "when called some arguments" do
      let(:args) { attributes_for(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_mappers, identifier: nil, Instrument: nil) }
      let(:data_set_list_item_list_element_mapper) { described_class.new(**args) }

      it { expect(data_set_list_item_list_element_mapper).to be_a described_class }
      it { expect(data_set_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
      it { expect(data_set_list_item_list_element_mapper.type).to eq args[:type] }
      it { expect(data_set_list_item_list_element_mapper.identifier).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.name).to eq args[:name] }
      it { expect(data_set_list_item_list_element_mapper.Instrument).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.descriptions).to eq args[:descriptions] }
      it { expect(data_set_list_item_list_element_mapper.attachmentList).to eq args[:attachmentList] }
    end
  end

  describe ".from_hash" do
    context "when called without any arguments" do
      let(:data_set_list_item_list_element_mapper) { build(:data_set_list_item_list_element_mapper) }

      it { expect(data_set_list_item_list_element_mapper).to be_a described_class }
      it { expect(data_set_list_item_list_element_mapper.type).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.identifier).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.name).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.Instrument).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.descriptions).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.attachmentList).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_hash) }
      let(:data_set_list_item_list_element_mapper) { described_class.from_hash args }

      it { expect(data_set_list_item_list_element_mapper).to be_a described_class }
      it { expect(data_set_list_item_list_element_mapper.type).to eq args[:type] }
      it { expect(data_set_list_item_list_element_mapper.identifier).to eq args[:identifier] }
      it { expect(data_set_list_item_list_element_mapper.name).to eq args[:name] }
      it { expect(data_set_list_item_list_element_mapper.Instrument).to eq args[:Instrument] }
      it { expect(data_set_list_item_list_element_mapper.descriptions).to eq args[:descriptions] }
      it { expect(data_set_list_item_list_element_mapper.attachmentList).to be_a AnalysisMappers::DataSetList::ItemListElement::AttachmentListMapper }
      it { expect(data_set_list_item_list_element_mapper.attachmentList.as_json).to eq args[:attachmentList].as_json }
    end

    context "when called some arguments" do
      let(:args) { attributes_for(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_hash, identifier: nil, Instrument: nil) }
      let(:data_set_list_item_list_element_mapper) { described_class.from_hash args }

      it { expect(data_set_list_item_list_element_mapper).to be_a described_class }
      it { expect(data_set_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
      it { expect(data_set_list_item_list_element_mapper.type).to eq args[:type] }
      it { expect(data_set_list_item_list_element_mapper.identifier).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.name).to eq args[:name] }
      it { expect(data_set_list_item_list_element_mapper.Instrument).to be_nil }
      it { expect(data_set_list_item_list_element_mapper.descriptions).to eq args[:descriptions] }
      it { expect(data_set_list_item_list_element_mapper.attachmentList.as_json).to eq args[:attachmentList].as_json }
    end
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:data_set_list_item_list_element_mapper) { build(:data_set_list_item_list_element_mapper) }

      let(:expected_json) do
        <<~JSON
          {
            "@type": #{expected_json_nil_render_value},
            "identifier":#{expected_json_nil_render_value},
            "name": #{expected_json_nil_render_value},
            "Instrument": #{expected_json_nil_render_value},
            "descriptions": #{expected_json_nil_render_value},
            "attachmentList" : #{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(data_set_list_item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_hash) }
      let(:data_set_list_item_list_element_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "@type": "#{args[:type]}",
            "identifier": "#{args[:identifier]}",
            "name": "#{args[:name]}",
            "Instrument": "#{args[:Instrument]}",
            "descriptions": "#{args[:descriptions]}",
            "attachmentList" : #{AnalysisMappers::DataSetList::ItemListElement::AttachmentListMapper.from_hash(args[:attachmentList]).to_json}
          }
        JSON
      end

      it { expect(JSON.parse(data_set_list_item_list_element_mapper.to_json)).to eq JSON.parse expected_json }
    end

    context "when called some arguments" do
      let(:args) { attributes_for(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_hash, identifier: nil, Instrument: nil) }
      let(:data_set_list_item_list_element_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "@type": "#{args[:type]}",
            "identifier": #{expected_json_nil_render_value},
            "name": "#{args[:name]}",
            "Instrument": #{expected_json_nil_render_value},
            "descriptions": "#{args[:descriptions]}",
            "attachmentList" : #{AnalysisMappers::DataSetList::ItemListElement::AttachmentListMapper.from_hash(args[:attachmentList]).to_json}
          }
        JSON
      end

      it { expect(JSON.parse(data_set_list_item_list_element_mapper.to_json)).to eq JSON.parse expected_json }
    end
  end

  describe "#to_xml" do
    context "when called without any arguments" do
      let(:data_set_list_item_list_element_mapper) { build(:data_set_list_item_list_element_mapper) }

      let(:expected_xml) do
        <<~XML
          <itemListElement>
            <type/>
            <identifier/>
            <name/>
            <Instrument/>
            <descriptions/>
            <attachmentList/>
          </itemListElement>
        XML
      end

      it { expect(data_set_list_item_list_element_mapper.to_xml).to eq_without_whitespace expected_xml }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_hash) }
      let(:data_set_list_item_list_element_mapper) { described_class.from_hash args }

      let(:expected_xml) do
        <<~XML
          <itemListElement>
            <type>DatasetEntity</type>
            <identifier>12345</identifier>
            <name>BJ68_1H</name>
            <Instrument>Bruker 400 MHz</Instrument>
            <descriptions>Bruker 400 MHz</descriptions>
            <attachmentList>
              <numberOfItems>2</numberOfItems>
              <itemListElement>
                <type>AttachmentEntity</type>
                <identifier>a63e278b-22f2-4da3-955f-e80e197bc853</identifier>
                <filename>BJ68_1H.zip</filename>
                <filepath>data/a63e278b-22f2-4da3-955f-e80e197bc853</filepath>
              </itemListElement>
              <itemListElement>
                <type>AttachmentEntity</type>
                <identifier>a63e278b-22f2-4da3-955f-e80e197bc853</identifier>
                <filename>HRMS.jpg</filename>
                <filepath>data/a63e278b-22f2-4da3-955f-e80e197bc853</filepath>
              </itemListElement>
            </attachmentList>
          </itemListElement>
        XML
      end

      it { expect(data_set_list_item_list_element_mapper.to_xml).to eq_without_whitespace expected_xml }
    end

    context "when called some arguments" do
      let(:args) { attributes_for(:data_set_list_item_list_element_mapper, :with_all_args_nested_structures_as_hash, identifier: nil, Instrument: nil) }
      let(:data_set_list_item_list_element_mapper) { described_class.from_hash args }

      let(:expected_xml) do
        <<~XML
          <itemListElement>
            <type>DatasetEntity</type>
            <identifier/>
            <name>BJ68_1H</name>
            <Instrument/>
            <descriptions>Bruker 400 MHz</descriptions>
            <attachmentList>
              <numberOfItems>2</numberOfItems>
              <itemListElement>
                <type>AttachmentEntity</type>
                <identifier>a63e278b-22f2-4da3-955f-e80e197bc853</identifier>
                <filename>BJ68_1H.zip</filename>
                <filepath>data/a63e278b-22f2-4da3-955f-e80e197bc853</filepath>
              </itemListElement>
              <itemListElement>
                <type>AttachmentEntity</type>
                <identifier>a63e278b-22f2-4da3-955f-e80e197bc853</identifier>
                <filename>HRMS.jpg</filename>
                <filepath>data/a63e278b-22f2-4da3-955f-e80e197bc853</filepath>
              </itemListElement>
            </attachmentList>
          </itemListElement>
        XML
      end

      it { expect(data_set_list_item_list_element_mapper.to_xml).to eq_without_whitespace expected_xml }
    end
  end
end
