describe API::V1::Publications::ChemotionId do
  let(:analysis) { create :analysis, :with_realistic_attributes }

  describe "GET /api/v1/publications/chemotion_id/:chemotion_id" do
    context "with existing chemotion_id" do
      before { get "/api/v1/publications/chemotion_id/#{analysis.id}" }

      let(:expected_json) { PublicationPresenter.present_by_chemotion_id(analysis.id).to_json }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq expected_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with NOT existing chemotion_id=0" do
      let(:not_existing_chemotion_id) { 0 }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with NOT existing chemotion_id=-1" do
      let(:not_existing_chemotion_id) { -1 }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end
  end

  describe "GET Analysis" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:attachment) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id }

    let(:expected_json) do
      <<~JSON
        {
          "@context": "https://schema.org/",
          "@id": "https://dx.doi.org/#{analysis.doi}",
          "@type": "AnalysisEntity",
          "datasetList": #{AnalysisMappers::DataSetListMapper.from_hash(AnalysisAdapter::DataSetListAdapter.new(analysis).to_h).to_json},
          "descriptions": {"ops":[{"insert":" "}, {"attributes":{"script":"super"},"insert":"13"}, {"insert":"C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]},
          "identifier": "#{attachment.analysis.chemotion_id}",
          "ontologies": "#{analysis.kind&.split("|")&.last&.strip}",
          "title": "#{analysis.kind&.split("|")&.last&.strip}",
          "url": "https://dx.doi.org/#{analysis.doi}"
        }
      JSON
    end

    before { get "/api/v1/publications/chemotion_id/#{attachment.analysis.id}" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  describe "GET Reaction" do
    let(:reaction) { create :reaction, :with_realistic_attributes }
    let(:attached_sample1) { create :sample, :with_realistic_attributes, reaction: }
    let(:attached_sample2) { create :sample, :with_realistic_attributes, reaction: }

    let(:expected_json) do
      <<~JSON
        {
          "@context":"https://schema.org/", 
          "@id":"#{reaction.doi}", 
          "@type":"BioChemicalReaction", 
          "name":"", 
          "identifier":"#{reaction.chemotion_id}", 
          "status":"#{reaction.reaction_status}", 
          "description":"--- !ruby/hash:Hashie::Mashops:\\n- !ruby/hash:Hashie::Mash\\n  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine\\n    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic\\n    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water\\n    were added. The precipitate was filtered off and washed with water. The crude\\n    product was recrystallized from ethanol to give 106 g of a colorless solid.\\n\\n'\\n", 
          "temperature":"#{reaction.temperature_user_text} #{reaction.temperature_value_unit}", 
          "reactionType":"#{reaction.rxno}", 
          "duration":"#{reaction.reaction_duration}", 
          "purification":"#{(reaction.reaction_purification || []).join(", ")}", 
          "reagentsList":#{ReactionMappers::ReagentsListMapper.from_hash(ReactionAdapter::ReagentsListAdapter.new(reaction).to_h).to_json}
        }
      JSON
    end

    before do
      attached_sample1
      attached_sample2
      get "/api/v1/publications/chemotion_id/#{reaction.id}"
    end

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  describe "GET Sample" do
    let(:sample) {
      create :sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [attachment1.analysis.id, attachment2.analysis.id],
                        "doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}
    }
    let(:attachment1) { create :attachment, :with_required_dependencies, :with_realistic_attributes }
    let(:attachment2) { create :attachment, :with_required_dependencies, :with_realistic_attributes }

    let(:expected_json) do
      <<~JSON
        {
          "@context": "https://schema.org/",
          "@id": "#{sample.doi}",
          "@type": "MolecularEntity",
          "analysisList": #{SampleMappers::AnalysisListMapper.from_hash(SampleAdapter::AnalysisListAdapter.new(sample).to_h).to_json},
          "boilingPoint": "#{sample.sample_boiling_point}",
          "dct:conformsTo": #{SampleMappers::DctConformsToMapper.from_hash(SampleAdapter::DctConformsToAdapter.new.to_h).to_json},
          "identifier": "#{sample.chemotion_id}",
          "inChI": "#{sample.inchistring}",
          "inChIKey": "#{sample.inchikey}",
          "iupacName": "#{sample.iupac_name}",
          "meltingPoint": "#{sample.sample_melting_point}",
          "molecularFormula": "#{sample.sum_formular}",
          "molecularWeight": #{SampleMappers::MolecularWeightMapper.from_hash(SampleAdapter::MolecularWeightAdapter.new(sample).to_h).to_json},
          "name": "#{sample.iupac_name}",
          "smiles": "#{sample.cano_smiles}",
          "url": "https://dx.doi.org/#{sample.doi}"
        }
      JSON
    end

    before { get "/api/v1/publications/chemotion_id/#{sample.id}" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end
end
