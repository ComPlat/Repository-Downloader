describe AnalysisMapper do
  let(:expected_json_nil_render_value) { "null" }
  let(:data_set_list_mapper) { build :data_set_list_mapper, :with_all_args_nested_structures_as_mappers }

  describe ".new" do
    context "when called without any arguments" do
      let(:analysis_mapper) { build :analysis_mapper }

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

      describe "#to_json" do
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
              "datasetList": #{expected_json_nil_render_value}
            }
          JSON
        end

        it { expect(analysis_mapper.to_json).to eq_without_whitespace expected_json }
      end
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :analysis_mapper, :with_all_args_nested_structures_as_mappers }
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
      it { expect(analysis_mapper.datasetList.to_json).to eq_without_whitespace data_set_list_mapper.to_json }

      describe "#to_json" do
        let(:expected_json) do
          <<~JSON
            {
              "@context":"#{args[:context]}",
              "@type":"#{args[:type]}",
              "@id":"#{args[:id]}",
              "ontologies":"#{args[:ontologies]}",
              "title":"#{args[:title]}",
              "descriptions":"#{args[:descriptions]}",
              "url":"#{args[:url]}",
              "identifier":"#{args[:identifier]}",
              "datasetList": #{data_set_list_mapper.to_json}
            }
          JSON
        end

        it { expect(analysis_mapper.to_json).to eq_without_whitespace expected_json }
      end
    end

    context "when called some arguments" do
      let(:args) { attributes_for :analysis_mapper, :with_all_args_nested_structures_as_mappers, ontologies: nil, descriptions: nil }
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
      it { expect(analysis_mapper.datasetList.to_json).to eq_without_whitespace data_set_list_mapper.to_json }

      describe "#to_json" do
        let(:expected_json) do
          <<~JSON
            {
              "@context":"#{args[:context]}",
              "@type":"#{args[:type]}",
              "@id":"#{args[:id]}",
              "ontologies":#{expected_json_nil_render_value},
              "title":"#{args[:title]}",
              "descriptions":#{expected_json_nil_render_value},
              "url":"#{args[:url]}",
              "identifier":"#{args[:identifier]}",
              "datasetList":#{data_set_list_mapper.to_json}
            }
          JSON
        end

        it { expect(analysis_mapper.to_json).to eq_without_whitespace expected_json }
      end
    end
  end

  describe ".from_hash" do
    let(:args) { attributes_for(:analysis_mapper, :with_all_args_nested_structures_as_hash) }
    let(:analysis_mapper) { described_class.from_hash args.deep_stringify_keys }

    let(:expected_data_set_list_item_list_element_mapper) { DataSetListMapper.from_hash(args[:datasetList]) }

    it { expect(analysis_mapper).to be_a described_class }
    it { expect(analysis_mapper.context).to eq args[:context] }
    it { expect(analysis_mapper.type).to eq args[:type] }
    it { expect(analysis_mapper.id).to eq args[:id] }
    it { expect(analysis_mapper.ontologies).to eq args[:ontologies] }
    it { expect(analysis_mapper.title).to eq args[:title] }
    it { expect(analysis_mapper.descriptions).to eq args[:descriptions] }
    it { expect(analysis_mapper.url).to eq args[:url] }
    it { expect(analysis_mapper.identifier).to eq args[:identifier] }
    it { expect(expected_data_set_list_item_list_element_mapper).to be_a DataSetListMapper }
    it { expect(analysis_mapper.datasetList.as_json).to eq args[:datasetList].as_json }
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:analysis_mapper) { build :analysis_mapper }

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
      let(:analysis_mapper) { described_class.from_hash args.deep_stringify_keys }

      let(:expected_json) do
        <<~JSON
          {
            "@context": "#{args[:context]}",
            "@type": "#{args[:type]}",
            "@id": "#{args[:id]}",
            "ontologies": "#{args[:ontologies]}",
            "title": "#{args[:title]}",
            "descriptions": "#{args[:descriptions]}",
            "url": "#{args[:url]}",
            "identifier": "#{args[:identifier]}",
            "datasetList":#{DataSetListMapper.from_hash(args[:datasetList].deep_stringify_keys).to_json}
          }
        JSON
      end

      it { expect(JSON.parse(analysis_mapper.to_json)).to eq JSON.parse expected_json }
    end
  end
end
