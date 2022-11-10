describe AnalysisPublicationMapper do
  let(:expected_json_nil_render_value) { "null" }

  context "when called without any arguments" do
    let(:analysis_publication_mapper) { build :analysis_publication_mapper }

    it { expect(analysis_publication_mapper).to be_a described_class }
    it { expect(analysis_publication_mapper).to be_a ShaleCustom::Mapper }
    it { expect(analysis_publication_mapper.context).to be_nil }
    it { expect(analysis_publication_mapper.type).to be_nil }
    it { expect(analysis_publication_mapper.id).to be_nil }
    it { expect(analysis_publication_mapper.ontologies).to be_nil }
    it { expect(analysis_publication_mapper.title).to be_nil }
    it { expect(analysis_publication_mapper.descriptions).to be_nil }
    it { expect(analysis_publication_mapper.url).to be_nil }
    it { expect(analysis_publication_mapper.identifier).to be_nil }
    # it { expect(analysis_publication_mapper.datasetList).to be_nil }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "context": #{expected_json_nil_render_value},
            "type": #{expected_json_nil_render_value},
            "id": #{expected_json_nil_render_value},
            "ontologies": #{expected_json_nil_render_value},
            "title": #{expected_json_nil_render_value},
            "descriptions": #{expected_json_nil_render_value},
            "url": #{expected_json_nil_render_value},
            "identifier": #{expected_json_nil_render_value}
          }
        JSON
      end

      it {
        expect(analysis_publication_mapper.to_json).to eq_without_whitespace expected_json
      }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :analysis_publication_mapper, :with_all_args }
      let(:analysis_publication_mapper) { described_class.new(**args) }

      it { expect(analysis_publication_mapper).to be_a described_class }
      it { expect(analysis_publication_mapper.context).to eq args[:context] }
      it { expect(analysis_publication_mapper.type).to eq args[:type] }
      it { expect(analysis_publication_mapper.id).to eq args[:id] }
      it { expect(analysis_publication_mapper.ontologies).to eq args[:ontologies] }
      it { expect(analysis_publication_mapper.title).to eq args[:title] }
      it { expect(analysis_publication_mapper.descriptions).to eq args[:descriptions] }
      it { expect(analysis_publication_mapper.url).to eq args[:url] }
      it { expect(analysis_publication_mapper.identifier).to eq args[:identifier] }

      describe "#to_json" do
        let(:expected_json) do
          <<~JSON
            {
              "context": "#{args[:context]}",
              "type": "#{args[:type]}",
              "id": "#{args[:id]}",
              "ontologies": "#{args[:ontologies]}",
              "title": "#{args[:title]}",
              "descriptions": "#{args[:descriptions]}",
              "url": "#{args[:url]}",
              "identifier": "#{args[:identifier]}"
            }
          JSON
        end

        it { expect(analysis_publication_mapper.to_json).to eq_without_whitespace expected_json }
      end
    end

    context "when called some arguments" do
      let(:args) { attributes_for :analysis_publication_mapper, :with_all_args, ontologies: nil, descriptions: nil }
      let(:analysis_publication_mapper) { described_class.new(**args) }

      it { expect(analysis_publication_mapper).to be_a described_class }
      it { expect(analysis_publication_mapper.context).to eq args[:context] }
      it { expect(analysis_publication_mapper.type).to eq args[:type] }
      it { expect(analysis_publication_mapper.id).to eq args[:id] }
      it { expect(analysis_publication_mapper.ontologies).to be_nil }
      it { expect(analysis_publication_mapper.title).to eq args[:title] }
      it { expect(analysis_publication_mapper.descriptions).to be_nil }
      it { expect(analysis_publication_mapper.url).to eq args[:url] }
      it { expect(analysis_publication_mapper.identifier).to eq args[:identifier] }

      describe "#to_json" do
        let(:expected_json) do
          <<~JSON
            {
              "context": "#{args[:context]}",
              "type": "#{args[:type]}",
              "id": "#{args[:id]}",
              "ontologies": #{expected_json_nil_render_value},
              "title": "#{args[:title]}",
              "descriptions": #{expected_json_nil_render_value},
              "url": "#{args[:url]}",
              "identifier": "#{args[:identifier]}"
            }
          JSON
        end

        it { expect(analysis_publication_mapper.to_json).to eq_without_whitespace expected_json }
      end
    end
  end
end
