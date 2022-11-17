describe SampleMapper do
  let(:expected_json_nil_render_value) { "null" }
  let(:analysis_list_mapper) { build :analysis_list_mapper, :with_all_args_nested_structures_as_mappers }
  let(:dct_element_mapper) { build :dct_element_mapper, :with_all_args_nested_structures_as_mappers }

  describe ".new" do
    context "when called without any arguments" do
      let(:sample_mapper) { build :sample_mapper }

      it { expect(sample_mapper).to be_a described_class }
      it { expect(sample_mapper).to be_a ShaleCustom::Mapper }
      it { expect(sample_mapper.context).to be_nil }
      it { expect(sample_mapper.type).to be_nil }
      it { expect(sample_mapper.dct_conformsTo).to be_nil }
      it { expect(sample_mapper.id).to be_nil }
      it { expect(sample_mapper.name).to be_nil }
      it { expect(sample_mapper.url).to be_nil }
      it { expect(sample_mapper.identifier).to be_nil }
      it { expect(sample_mapper.iupacName).to be_nil }
      it { expect(sample_mapper.smiles).to be_nil }
      it { expect(sample_mapper.inChI).to be_nil }
      it { expect(sample_mapper.inChIKey).to be_nil }
      it { expect(sample_mapper.molecularFormula).to be_nil }
      it { expect(sample_mapper.meltingPoint).to be_nil }
      it { expect(sample_mapper.boilingPoint).to be_nil }
      it { expect(sample_mapper.molecularWeight).to be_nil }
      it { expect(sample_mapper.analysisList).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :sample_mapper, :with_all_args }
      let(:sample_mapper) { described_class.new(**args) }

      it { expect(sample_mapper).to be_a described_class }
      it { expect(sample_mapper.context).to eq args[:context] }
      it { expect(sample_mapper.type).to eq args[:type] }
      it { expect(sample_mapper.dct_conformsTo).to eq args[:dct_conformsTo] }
      it { expect(sample_mapper.id).to eq args[:id] }
      it { expect(sample_mapper.name).to eq args[:name] }
      it { expect(sample_mapper.url).to eq args[:url] }
      it { expect(sample_mapper.identifier).to eq args[:identifier] }
      it { expect(sample_mapper.iupacName).to eq args[:iupacName] }
      it { expect(sample_mapper.smiles).to eq args[:smiles] }
      it { expect(sample_mapper.inChI).to eq args[:inChI] }
      it { expect(sample_mapper.inChIKey).to eq args[:inChIKey] }
      it { expect(sample_mapper.molecularFormula).to eq args[:molecularFormula] }
      it { expect(sample_mapper.meltingPoint).to eq args[:meltingPoint] }
      it { expect(sample_mapper.boilingPoint).to eq args[:boilingPoint] }
      it { expect(sample_mapper.molecularWeight).to eq args[:molecularWeight] }
      it { expect(sample_mapper.analysisList.to_json).to eq_without_whitespace analysis_list_mapper.to_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for :sample_mapper, :with_all_args, name: nil, identifier: nil }
      let(:sample_mapper) { described_class.new(**args) }

      it { expect(sample_mapper).to be_a described_class }
      it { expect(sample_mapper.context).to eq args[:context] }
      it { expect(sample_mapper.type).to eq args[:type] }
      it { expect(sample_mapper.dct_conformsTo).to eq args[:dct_conformsTo] }
      it { expect(sample_mapper.id).to eq args[:id] }
      it { expect(sample_mapper.name).to eq args[:name] }
      it { expect(sample_mapper.url).to eq args[:url] }
      it { expect(sample_mapper.identifier).to eq args[:identifier] }
      it { expect(sample_mapper.iupacName).to eq args[:iupacName] }
      it { expect(sample_mapper.smiles).to eq args[:smiles] }
      it { expect(sample_mapper.inChI).to eq args[:inChI] }
      it { expect(sample_mapper.inChIKey).to eq args[:inChIKey] }
      it { expect(sample_mapper.molecularFormula).to eq args[:molecularFormula] }
      it { expect(sample_mapper.meltingPoint).to eq args[:meltingPoint] }
      it { expect(sample_mapper.boilingPoint).to eq args[:boilingPoint] }
      it { expect(sample_mapper.molecularWeight).to eq args[:molecularWeight] }
      it { expect(sample_mapper.analysisList.to_json).to eq_without_whitespace analysis_list_mapper.to_json }
    end
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:sample_mapper) { build :sample_mapper }

      let(:expected_json) do
        <<~JSON
          {
            "@context": #{expected_json_nil_render_value},
            "@type": #{expected_json_nil_render_value},
            "dct:conformsTo": #{expected_json_nil_render_value},
            "@id": #{expected_json_nil_render_value},
            "name": #{expected_json_nil_render_value},
            "url": #{expected_json_nil_render_value},
            "identifier": #{expected_json_nil_render_value},
            "iupacName": #{expected_json_nil_render_value},
            "smiles": #{expected_json_nil_render_value},
            "inChI": #{expected_json_nil_render_value},
            "inChIKey": #{expected_json_nil_render_value},        
            "molecularFormula": #{expected_json_nil_render_value},
            "meltingPoint": #{expected_json_nil_render_value},
            "boilingPoint": #{expected_json_nil_render_value},
            "molecularWeight": #{expected_json_nil_render_value},
            "analysisList": #{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(sample_mapper.to_json).to eq_without_whitespace expected_json }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :sample_mapper, :with_all_args }
      let(:sample_mapper) { described_class.new(**args) }

      let(:expected_json) do
        <<~JSON
          {
            "@context": #{args[:context]},
            "@type": #{args[:type]},
            "dct:conformsTo": #{dct_element_mapper.to_json},
            "@id": #{args[:id]},
            "name": #{args[:name]},
            "url": #{args[:url]},
            "identifier": #{args[:identifier]},
            "iupacName": #{args[:iupacName]},
            "smiles": #{args[:smiles]},
            "inChI": #{args[:inChI]},
            "inChIKey": #{args[:inChIKey]},        
            "molecularFormula": #{args[:molecularFormula]},
            "meltingPoint": #{args[:meltingPoint]},
            "boilingPoint": #{args[:boilingPoint]},
            "molecularWeight": #{args[:molecularWeight]},
            "analysisList": #{analysis_list_mapper.to_json}
          }
        JSON
      end

      it { expect(sample_mapper.to_json).to eq_without_whitespace expected_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for :sample_mapper, :with_all_args, name: nil, identifier: nil }
      let(:sample_mapper) { described_class.new(**args) }

      let(:expected_json) do
        <<~JSON
          {
            "@context": #{args[:context]},
            "@type": #{args[:type]},
            "dct:conformsTo": #{dct_element_mapper.to_json},
            "@id": #{args[:id]},
            "name":#{expected_json_nil_render_value},
            "url": #{args[:url]},
            "identifier": #{args[:identifier]},
            "iupacName": #{args[:iupacName]},
            "smiles": #{args[:smiles]},
            "inChI": #{args[:inChI]},
            "inChIKey": #{args[:inChIKey]},        
            "molecularFormula": #{args[:molecularFormula]},
            "meltingPoint": #{args[:meltingPoint]},
            "boilingPoint": #{args[:boilingPoint]},
            "molecularWeight": #{args[:molecularWeight]},
            "analysisList": #{analysis_list_mapper.to_json}
          }
        JSON
      end

      it { expect(sample_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
