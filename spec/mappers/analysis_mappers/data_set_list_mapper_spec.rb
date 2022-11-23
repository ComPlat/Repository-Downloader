describe AnalysisMappers::DataSetListMapper do
  describe "factories" do
    describe "trait :with_all_args_nested_structures_as_mappers" do
      subject(:factory) { build :data_set_list_mapper, :with_all_args_nested_structures_as_mappers }

      it { expect(factory.instance_variable_get(:@itemListElement).count).to eq 1 }
      it { expect(factory.instance_variable_get(:@itemListElement).count).to eq factory.instance_variable_get :@numberOfItems }
      it { expect(factory.instance_variable_get(:@itemListElement)).to all be_a AnalysisMappers::DataSetList::ItemListElementMapper }
    end

    describe "trait :with_all_args_nested_structures_as_hash" do
      subject(:factory) { build :data_set_list_mapper, :with_all_args_nested_structures_as_hash }

      it { expect(factory.instance_variable_get(:@itemListElement).count).to eq 1 }
      it { expect(factory.instance_variable_get(:@itemListElement).count).to eq factory.instance_variable_get :@numberOfItems }
      it { expect(factory.instance_variable_get(:@itemListElement)).to all be_a Hash }
    end
  end

  describe ".new" do
    context "when called without any arguments" do
      let(:data_set_list_mapper) { build :data_set_list_mapper }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper).to be_a ShaleCustom::Mapper }
      it { expect(data_set_list_mapper.numberOfItems).to be_nil }
      it { expect(data_set_list_mapper.itemListElement).to match_array([]) }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :data_set_list_mapper, :with_all_args_nested_structures_as_mappers }
      let(:data_set_list_mapper) { described_class.new(**args) }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(data_set_list_mapper.itemListElement).to eq args[:itemListElement] }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for :data_set_list_mapper, :with_all_args_nested_structures_as_mappers, numberOfItems: nil }
      let(:data_set_list_mapper) { described_class.new(**args) }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper.numberOfItems).to be_nil }
      it { expect(data_set_list_mapper.itemListElement).to eq args[:itemListElement] }
    end
  end

  describe ".from_hash" do
    context "when called without any arguments" do
      let(:data_set_list_mapper) { build :data_set_list_mapper }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper.numberOfItems).to be_nil }
      it { expect(data_set_list_mapper.itemListElement).to eq [] }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:data_set_list_mapper, :with_all_args_nested_structures_as_hash) }
      let(:data_set_list_mapper) { described_class.from_hash args }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(data_set_list_mapper.itemListElement).to all be_a AnalysisMappers::DataSetList::ItemListElementMapper }
      it { expect(data_set_list_mapper.itemListElement.as_json).to eq args[:itemListElement].as_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for :data_set_list_mapper, :with_all_args_nested_structures_as_hash, numberOfItems: nil }
      let(:data_set_list_mapper) { described_class.from_hash args }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper.numberOfItems).to be_nil }
      it { expect(data_set_list_mapper.itemListElement.as_json).to eq args[:itemListElement].as_json }
    end
  end

  describe "#to_json" do
    let(:expected_json_nil_render_value) { "null" }

    context "when called without any arguments" do
      let(:data_set_list_mapper) { build :data_set_list_mapper }

      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems":#{expected_json_nil_render_value},
            "itemListElement":[]
          }
        JSON
      end

      it { expect(JSON.parse(data_set_list_mapper.to_json)).to eq JSON.parse expected_json }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:data_set_list_mapper, :with_all_args_nested_structures_as_hash) }
      let(:data_set_list_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems":#{args[:numberOfItems]},
            "itemListElement":#{MappersPresenter.new(AnalysisMappers::DataSetList::ItemListElementMapper, args[:itemListElement]).to_json}
          }
        JSON
      end

      it { expect(JSON.parse(data_set_list_mapper.to_json)).to eq JSON.parse expected_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for :data_set_list_mapper, :with_all_args_nested_structures_as_hash, numberOfItems: nil }
      let(:data_set_list_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems":#{expected_json_nil_render_value},
            "itemListElement":#{MappersPresenter.new(AnalysisMappers::DataSetList::ItemListElementMapper, args[:itemListElement]).to_json}
          }
        JSON
      end

      it { expect(JSON.parse(data_set_list_mapper.to_json)).to eq JSON.parse expected_json }
    end
  end

  describe "#to_xml" do
    context "when called without any arguments" do
      let(:data_set_list_mapper) { build :data_set_list_mapper }

      let(:expected_xml) do
        <<~XML
          <dataSetList>
            <numberOfItems/>
          </dataSetList>
        XML
      end

      it { expect(data_set_list_mapper.to_xml).to eq_without_whitespace expected_xml }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:data_set_list_mapper, :with_all_args_nested_structures_as_hash) }
      let(:data_set_list_mapper) { described_class.from_hash args }

      let(:expected_xml) do
        <<~XML
          <dataSetList>
            <numberOfItems>1</numberOfItems>
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
          </dataSetList>
        XML
      end

      it { expect(data_set_list_mapper.to_xml).to eq_without_whitespace expected_xml }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for :data_set_list_mapper, :with_all_args_nested_structures_as_hash, numberOfItems: nil }
      let(:data_set_list_mapper) { described_class.from_hash args }

      let(:expected_xml) do
        <<~XML
          <dataSetList>
            <numberOfItems/>
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
          </dataSetList>
        XML
      end

      it { expect(data_set_list_mapper.to_xml).to eq_without_whitespace expected_xml }
    end
  end
end
