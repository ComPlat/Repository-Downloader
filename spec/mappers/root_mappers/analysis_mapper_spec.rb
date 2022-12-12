describe RootMappers::AnalysisMapper do
  let(:expected_json_nil_render_value) { "null" }

  describe ".new" do
    context "when called without any arguments" do
      let(:analysis_mapper) { build(:analysis_mapper) }

      it { expect(analysis_mapper).to be_a described_class }
      it { expect(analysis_mapper).to be_a ShaleCustom::Mapper }
      it { expect(analysis_mapper.context).to be_nil }
      it { expect(analysis_mapper.type).to be_nil }
      it { expect(analysis_mapper.id).to be_nil }
      it { expect(analysis_mapper.ontologies).to be_nil }
      it { expect(analysis_mapper.title).to be_nil }
      it { expect(analysis_mapper.descriptions).to be_nil }
      it { expect(analysis_mapper.url).to be_nil }
      it { expect(analysis_mapper.identifier).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_mappers) }
      let(:analysis_mapper) { described_class.new(**args) }

      it { expect(analysis_mapper).to be_a described_class }
      it { expect(analysis_mapper.context).to eq args[:context] }
      it { expect(analysis_mapper.type).to eq args[:type] }
      it { expect(analysis_mapper.id).to eq args[:id] }
      it { expect(analysis_mapper.ontologies).to eq args[:ontologies] }
      it { expect(analysis_mapper.title).to eq args[:title] }
      it { expect(analysis_mapper.descriptions).to eq args[:descriptions] }
      it { expect(analysis_mapper.url).to eq args[:url] }
      it { expect(analysis_mapper.identifier).to eq args[:identifier] }
      it { expect(analysis_mapper.datasetList).to eq args[:datasetList] }
    end

    context "when called some arguments" do
      let(:args) { attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_mappers, ontologies: nil, descriptions: nil) }
      let(:analysis_mapper) { described_class.new(**args) }

      it { expect(analysis_mapper).to be_a described_class }
      it { expect(analysis_mapper.context).to eq args[:context] }
      it { expect(analysis_mapper.type).to eq args[:type] }
      it { expect(analysis_mapper.id).to eq args[:id] }
      it { expect(analysis_mapper.ontologies).to be_nil }
      it { expect(analysis_mapper.title).to eq args[:title] }
      it { expect(analysis_mapper.descriptions).to be_nil }
      it { expect(analysis_mapper.url).to eq args[:url] }
      it { expect(analysis_mapper.identifier).to eq args[:identifier] }
      it { expect(analysis_mapper.datasetList).to eq args[:datasetList] }
    end
  end

  describe ".from_hash" do
    context "when called without any arguments" do
      let(:analysis_mapper) { build(:analysis_mapper) }

      it { expect(analysis_mapper).to be_a described_class }
      it { expect(analysis_mapper.context).to be_nil }
      it { expect(analysis_mapper.type).to be_nil }
      it { expect(analysis_mapper.id).to be_nil }
      it { expect(analysis_mapper.ontologies).to be_nil }
      it { expect(analysis_mapper.title).to be_nil }
      it { expect(analysis_mapper.descriptions).to be_nil }
      it { expect(analysis_mapper.url).to be_nil }
      it { expect(analysis_mapper.identifier).to be_nil }
      it { expect(analysis_mapper.datasetList).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_hash) }
      let(:analysis_mapper) { described_class.from_hash args }

      let(:expected_data_set_list_mapper) { AnalysisMappers::DataSetListMapper.from_hash(args[:datasetList]) }

      it { expect(analysis_mapper).to be_a described_class }
      it { expect(analysis_mapper.context).to eq args[:context] }
      it { expect(analysis_mapper.type).to eq args[:type] }
      it { expect(analysis_mapper.id).to eq args[:id] }
      it { expect(analysis_mapper.ontologies).to eq args[:ontologies] }
      it { expect(analysis_mapper.title).to eq args[:title] }
      it { expect(analysis_mapper.descriptions).to eq args[:descriptions] }
      it { expect(analysis_mapper.url).to eq args[:url] }
      it { expect(analysis_mapper.identifier).to eq args[:identifier] }
      it { expect(expected_data_set_list_mapper).to be_a AnalysisMappers::DataSetListMapper }
      it { expect(analysis_mapper.datasetList.as_json).to eq args[:datasetList].as_json }
    end

    context "when called some arguments" do
      let(:args) { attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_hash, ontologies: nil, descriptions: nil) }
      let(:analysis_mapper) { described_class.from_hash args }

      let(:expected_data_set_list_mapper) { AnalysisMappers::DataSetListMapper.from_hash(args[:datasetList]) }

      it { expect(analysis_mapper).to be_a described_class }
      it { expect(analysis_mapper.context).to eq args[:context] }
      it { expect(analysis_mapper.type).to eq args[:type] }
      it { expect(analysis_mapper.id).to eq args[:id] }
      it { expect(analysis_mapper.ontologies).to be_nil }
      it { expect(analysis_mapper.title).to eq args[:title] }
      it { expect(analysis_mapper.descriptions).to be_nil }
      it { expect(analysis_mapper.url).to eq args[:url] }
      it { expect(analysis_mapper.identifier).to eq args[:identifier] }
      it { expect(expected_data_set_list_mapper).to be_a AnalysisMappers::DataSetListMapper }
      it { expect(analysis_mapper.datasetList.as_json).to eq args[:datasetList].as_json }
    end
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:analysis_mapper) { build(:analysis_mapper) }

      let(:expected_json) do
        <<~JSON
          {
            "@context": #{expected_json_nil_render_value},
            "@type": #{expected_json_nil_render_value},
            "@id": #{expected_json_nil_render_value},
            "ontologies": #{expected_json_nil_render_value},
            "title": #{expected_json_nil_render_value},
            "descriptions": #{expected_json_nil_render_value},
            "url": #{expected_json_nil_render_value},
            "identifier": #{expected_json_nil_render_value},
            "datasetList":#{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(JSON.parse(analysis_mapper.to_json)).to eq JSON.parse expected_json }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_hash) }
      let(:analysis_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "@context": "#{args[:context]}",
            "@type": "#{args[:type]}",
            "@id": "#{args[:id]}",
            "ontologies": "#{args[:ontologies]}",
            "title": "#{args[:title]}",
            "descriptions": #{args[:descriptions].to_json},
            "url": "#{args[:url]}",
            "identifier": "#{args[:identifier]}",
            "datasetList":#{AnalysisMappers::DataSetListMapper.from_hash(args[:datasetList]).to_json}
          }
        JSON
      end

      it { expect(JSON.parse(analysis_mapper.to_json)).to eq JSON.parse expected_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_hash, ontologies: nil, descriptions: nil) }
      let(:analysis_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "@context": "#{args[:context]}",
            "@type": "#{args[:type]}",
            "@id": "#{args[:id]}",
            "ontologies": #{expected_json_nil_render_value},
            "title": "#{args[:title]}",
            "descriptions": #{expected_json_nil_render_value},
            "url": "#{args[:url]}",
            "identifier": "#{args[:identifier]}",
            "datasetList":#{AnalysisMappers::DataSetListMapper.from_hash(args[:datasetList]).to_json}
          }
        JSON
      end

      it { expect(JSON.parse(analysis_mapper.to_json)).to eq JSON.parse expected_json }
    end
  end

  describe "#to_xml" do
    context "when called without any arguments" do
      let(:analysis_mapper) { build(:analysis_mapper) }

      let(:expected_xml) do
        <<~XML
          <analysis>
            <context/>
            <type/>
            <id/>
            <ontologies/>
            <title/>
            <descriptions/>
            <url/>
            <identifier/>
            <datasetList/>
          </analysis>
        XML
      end

      it { expect(analysis_mapper.to_xml).to eq_without_whitespace expected_xml }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_hash) }
      let(:analysis_mapper) { described_class.from_hash args }

      let(:expected_xml) do
        <<~XML
          <analysis>
            <context>https://schema.org/</context>
            <type>AnalysisEntity</type>
            <id>https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595</id>
            <ontologies>13C nuclear magnetic resonance spectroscopy (13C NMR)</ontologies>
            <title>13C nuclear magnetic resonance spectroscopy (13C NMR) (4-(2-oxo-2-phenylacetyl)benzoic acid)</title>
            <descriptions>{"ops"=&gt;[{"insert"=&gt;"&#xA0;"}, {"attributes"=&gt;{"script"=&gt;"super"}, "insert"=&gt;"13"}, {"insert"=&gt;"C NMR (100 MHz, DMSO-d6, ppm), &#x3B4; = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]}</descriptions>
            <url>https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595</url>
            <identifier>CRD-27923</identifier>
            <datasetList>
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
            </datasetList>
          </analysis>
        XML
      end

      it { expect(analysis_mapper.to_xml).to eq_without_whitespace expected_xml }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_hash, ontologies: nil, descriptions: nil) }
      let(:analysis_mapper) { described_class.from_hash args }

      let(:expected_xml) do
        <<~XML
          <analysis>
            <context>https://schema.org/</context>
            <type>AnalysisEntity</type>
            <id>https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595</id>
            <ontologies/>
            <title>13C nuclear magnetic resonance spectroscopy (13C NMR) (4-(2-oxo-2-phenylacetyl)benzoic acid)</title>
            <descriptions/>
            <url>https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595</url>
            <identifier>CRD-27923</identifier>
            <datasetList>
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
            </datasetList>
          </analysis>
        XML
      end

      it { expect(analysis_mapper.to_xml).to eq_without_whitespace expected_xml }
    end
  end
end
