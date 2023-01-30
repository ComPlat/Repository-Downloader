describe RootMappers::SampleMapper do
  let(:expected_json_nil_render_value) { "null" }
  let(:analysis_list_mapper) { build(:analysis_list_mapper, :with_all_args_nested_structures_as_mappers) }

  describe ".new" do
    context "when called without any arguments" do
      let(:sample_mapper) { build(:sample_mapper) }

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
      let(:args) { attributes_for(:sample_mapper, :with_all_args_nested_structures_as_mappers) }
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
      let(:args) { attributes_for(:sample_mapper, :with_all_args_nested_structures_as_mappers, name: nil, identifier: nil) }
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

  describe ".from_hash" do
    context "when called without any arguments" do
      let(:sample_mapper) { build(:sample_mapper) }

      it { expect(sample_mapper).to be_a described_class }
      it { expect(sample_mapper.dct_conformsTo).to be_nil }
    end

    context "when called with_all_args_nested_structures_as_hash" do
      let(:args) { attributes_for(:sample_mapper, :with_all_args_nested_structures_as_hash) }
      let(:sample_mapper) { described_class.from_hash args }

      it { expect(sample_mapper).to be_a described_class }
      it { expect(sample_mapper.dct_conformsTo.as_json).to eq args[:dct_conformsTo].as_json }
      it { expect(sample_mapper.dct_conformsTo).to be_a SampleMappers::DctConformsToMapper }
    end
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:sample_mapper) { build(:sample_mapper) }

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
      let(:args) { attributes_for(:sample_mapper, :with_all_args_nested_structures_as_mappers) }
      let(:sample_mapper) { described_class.new(**args) }

      let(:expected_json) do
        <<~JSON
          {
            "@context": "#{args[:context]}",
            "@type": "#{args[:type]}",
            "dct:conformsTo": #{sample_mapper.dct_conformsTo.to_json},
            "@id": "#{args[:id]}",
            "name": "#{args[:name]}",
            "url": "#{args[:url]}",
            "identifier": "#{args[:identifier]}",
            "iupacName": "#{args[:iupacName]}",
            "smiles": "#{args[:smiles]}",
            "inChI": "#{args[:inChI]}",
            "inChIKey": "#{args[:inChIKey]}",
            "molecularFormula": "#{args[:molecularFormula]}",
            "meltingPoint": "#{args[:meltingPoint]}",
            "boilingPoint": "#{args[:boilingPoint]}",
            "molecularWeight": #{args[:molecularWeight].to_json},
            "analysisList": #{analysis_list_mapper.to_json}
          }
        JSON
      end

      it {
        expect(JSON.parse(sample_mapper.to_json)).to eq JSON.parse(expected_json)
      }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:sample_mapper, :with_all_args_nested_structures_as_mappers, name: nil, identifier: nil) }
      let(:sample_mapper) { described_class.new(**args) }

      let(:expected_json) do
        <<~JSON
          {
            "@context": "#{args[:context]}",
            "@type": "#{args[:type]}",
            "dct:conformsTo": #{sample_mapper.dct_conformsTo.to_json},
            "@id": "#{args[:id]}",
            "name":#{expected_json_nil_render_value},
            "url": "#{args[:url]}",
            "identifier": #{expected_json_nil_render_value},
            "iupacName": "#{args[:iupacName]}",
            "smiles": "#{args[:smiles]}",
            "inChI": "#{args[:inChI]}",
            "inChIKey": "#{args[:inChIKey]}",        
            "molecularFormula": "#{args[:molecularFormula]}",
            "meltingPoint": "#{args[:meltingPoint]}",
            "boilingPoint": "#{args[:boilingPoint]}",
            "molecularWeight": #{args[:molecularWeight].to_json},
            "analysisList": #{analysis_list_mapper.to_json}
          }
        JSON
      end

      it { expect(JSON.parse(sample_mapper.to_json)).to eq JSON.parse expected_json }
    end
  end

  describe "#to_csv" do
    context "when called without any arguments" do
      let(:sample_mapper) { build(:sample_mapper) }

      let(:expected_csv) do
        <<~CSV
          context,type,dct:conformsTo,id,name,url,identifier,iupacName,smiles,inChI,inChIKey,molecularFormula,meltingPoint,boilingPoint,molecularWeight,analysisList
          ,,,,,,,,,,,,,,,
        CSV
      end

      it { expect(sample_mapper.to_csv).to eq_without_whitespace expected_csv }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:sample_mapper, :with_all_args_nested_structures_as_mappers) }
      let(:sample_mapper) { described_class.new(**args) }

      let(:expected_csv) do
        <<~CSV
          context,type,dct:conformsTo.dct_conformsTo.type,dct:conformsTo.dct_conformsTo.id,id,name,url,identifier,iupacName,smiles,inChI,inChIKey,molecularFormula,meltingPoint,boilingPoint,molecularWeight.value,analysisList.numberOfItems,analysisList.itemListElement1.context,analysisList.itemListElement1.type,analysisList.itemListElement1.id,analysisList.itemListElement1.ontologies,analysisList.itemListElement1.title,analysisList.itemListElement1.descriptions,analysisList.itemListElement1.url,analysisList.itemListElement1.identifier,analysisList.itemListElement1.datasetList.numberOfItems,analysisList.itemListElement1.datasetList.itemListElement1.type,analysisList.itemListElement1.datasetList.itemListElement1.identifier,analysisList.itemListElement1.datasetList.itemListElement1.name,analysisList.itemListElement1.datasetList.itemListElement1.Instrument,analysisList.itemListElement1.datasetList.itemListElement1.descriptions,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.numberOfItems,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement1.type,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement1.identifier,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement1.filename,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement1.filepath,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement2.type,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement2.identifier,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement2.filename,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement2.filepath
          https://schema.org/,MolecularEntity,CreativeWork,https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/,10.14272/MIIFHRBUBUHJMC-UHFFFAOYSA-N.1,ethyl 3-oxo-4H-quinoxaline-2-carboxylate,http://chemotion-repository.net/home/publications/molecules/6338,chemotion ID ?,ethyl 3-oxo-4H-quinoxaline-2-carboxylate,CCOC(=O)c1nc2ccccc2nc1O,"InChI=1S/C11H10N2O3/c1-2-16-11(15)9-10(14)13-8-6-4-3-5-7(8)12-9/h3-6H,2H2,1H3,(H,13,14)",MIIFHRBUBUHJMC-UHFFFAOYSA-N,C11H10N2O3,10 - 20 °C,20 °C,218.20870000000002,1,https://schema.org/,AnalysisEntity,https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595,13C nuclear magnetic resonance spectroscopy (13C NMR),13C nuclear magnetic resonance spectroscopy (13C NMR) (4-(2-oxo-2-phenylacetyl)benzoic acid),{'ops':[{'insert':' '};{'attributes':{'script':'super'};'insert':'13'};{'insert':'C NMR (100 MHz; DMSO-d6; ppm); δ = 171.0; 141.1; 135.4 (q; J = 5.2 Hz); 127.4; 124.3 (q; J = 4.2 Hz); 124.0 (q; J = 271.3 Hz); 118.9; 118.2; 111.3 (q; J = 33.3 Hz); 44.4; 25.6; 22.3 (2 C). '}]},https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595,CRD-27923,1,DatasetEntity,12345,BJ68_1H,Bruker 400 MHz,Bruker 400 MHz,2,AttachmentEntity,a63e278b-22f2-4da3-955f-e80e197bc853,BJ68_1H.zip,data/a63e278b-22f2-4da3-955f-e80e197bc853,AttachmentEntity,a63e278b-22f2-4da3-955f-e80e197bc853,HRMS.jpg,data/a63e278b-22f2-4da3-955f-e80e197bc853
        CSV
      end

      it { expect(sample_mapper.to_csv).to eq expected_csv }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:sample_mapper, :with_all_args_nested_structures_as_mappers, name: nil, identifier: nil) }
      let(:sample_mapper) { described_class.new(**args) }

      let(:expected_csv) do
        <<~CSV
          context,type,dct:conformsTo.dct_conformsTo.type,dct:conformsTo.dct_conformsTo.id,id,name,url,identifier,iupacName,smiles,inChI,inChIKey,molecularFormula,meltingPoint,boilingPoint,molecularWeight.value,analysisList.numberOfItems,analysisList.itemListElement1.context,analysisList.itemListElement1.type,analysisList.itemListElement1.id,analysisList.itemListElement1.ontologies,analysisList.itemListElement1.title,analysisList.itemListElement1.descriptions,analysisList.itemListElement1.url,analysisList.itemListElement1.identifier,analysisList.itemListElement1.datasetList.numberOfItems,analysisList.itemListElement1.datasetList.itemListElement1.type,analysisList.itemListElement1.datasetList.itemListElement1.identifier,analysisList.itemListElement1.datasetList.itemListElement1.name,analysisList.itemListElement1.datasetList.itemListElement1.Instrument,analysisList.itemListElement1.datasetList.itemListElement1.descriptions,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.numberOfItems,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement1.type,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement1.identifier,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement1.filename,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement1.filepath,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement2.type,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement2.identifier,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement2.filename,analysisList.itemListElement1.datasetList.itemListElement1.attachmentList.itemListElement2.filepath
          https://schema.org/,MolecularEntity,CreativeWork,https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/,10.14272/MIIFHRBUBUHJMC-UHFFFAOYSA-N.1,,http://chemotion-repository.net/home/publications/molecules/6338,,ethyl 3-oxo-4H-quinoxaline-2-carboxylate,CCOC(=O)c1nc2ccccc2nc1O,"InChI=1S/C11H10N2O3/c1-2-16-11(15)9-10(14)13-8-6-4-3-5-7(8)12-9/h3-6H,2H2,1H3,(H,13,14)",MIIFHRBUBUHJMC-UHFFFAOYSA-N,C11H10N2O3,10 - 20 °C,20 °C,218.20870000000002,1,https://schema.org/,AnalysisEntity,https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595,13C nuclear magnetic resonance spectroscopy (13C NMR),13C nuclear magnetic resonance spectroscopy (13C NMR) (4-(2-oxo-2-phenylacetyl)benzoic acid),{'ops':[{'insert':' '};{'attributes':{'script':'super'};'insert':'13'};{'insert':'C NMR (100 MHz; DMSO-d6; ppm); δ = 171.0; 141.1; 135.4 (q; J = 5.2 Hz); 127.4; 124.3 (q; J = 4.2 Hz); 124.0 (q; J = 271.3 Hz); 118.9; 118.2; 111.3 (q; J = 33.3 Hz); 44.4; 25.6; 22.3 (2 C). '}]},https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595,CRD-27923,1,DatasetEntity,12345,BJ68_1H,Bruker 400 MHz,Bruker 400 MHz,2,AttachmentEntity,a63e278b-22f2-4da3-955f-e80e197bc853,BJ68_1H.zip,data/a63e278b-22f2-4da3-955f-e80e197bc853,AttachmentEntity,a63e278b-22f2-4da3-955f-e80e197bc853,HRMS.jpg,data/a63e278b-22f2-4da3-955f-e80e197bc853
        CSV
      end

      it { expect(sample_mapper.to_csv).to eq expected_csv }
    end
  end
end
