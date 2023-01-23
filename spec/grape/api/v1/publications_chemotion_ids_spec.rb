describe API::V1::Publications, ".chemotion_ids" do
  let(:analysis1) { create(:analysis, :with_realistic_attributes) }
  let(:reaction1) { create(:reaction, :with_realistic_attributes) }

  describe "GET /api/v1/publications?chemotion_ids={analysis1.id}&format=json" do
    context "with existing chemotion_id" do
      before { get "/api/v1/publications?chemotion_ids=#{analysis1.id}&format=json" }

      let(:expected_json) do
        json = []
        PublicationsByChemotionIdPresenter.new(analysis1.id).to_json.each { |chunk| json << chunk }
        json.join
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq expected_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with NOT existing chemotion_id=1&format=json" do
      let(:not_existing_chemotion_id) { 1 }

      before { get "/api/v1/publications?chemotion_ids=#{not_existing_chemotion_id}&format=json" }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq [].to_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with NOT existing and invalid because negative chemotion_id=-1" do
      let(:invalid_chemotion_id) { -1 }

      before { get "/api/v1/publications?chemotion_ids=#{invalid_chemotion_id}&format=json" }

      it { expect(response).to have_http_status :bad_request }
      it { expect(JSON.parse(response.body)).to eq({"error" => "chemotion_ids is invalid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with illegal chemotion_id format containing alphabetical characters" do
      let(:not_existing_chemotion_id) { "ABC" }

      before { get "/api/v1/publications?chemotion_ids=#{not_existing_chemotion_id}&format=json" }

      it { expect(response).to have_http_status :bad_request }
      it { expect(JSON.parse(response.body)).to eq({"error" => "chemotion_ids is invalid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end
  end

  describe "GET /api/v1/publications?chemotion_ids={analysis1.id},{analysis2.id}&format=json" do
    context "with two existing chemotion_id" do
      before { get "/api/v1/publications?chemotion_ids=#{analysis1.id},#{reaction1.id}&format=json" }

      let(:expected_json) do
        json = []
        PublicationsByChemotionIdPresenter.new([analysis1.id, reaction1.id]).to_json.each { |chunk| json << chunk }
        json.join
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq expected_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with one not existing chemotion_id=1" do
      let(:not_existing_chemotion_id) { 1 }
      let(:expected_json) do
        json = []
        PublicationsByChemotionIdPresenter.new(analysis1.id).to_json.each { |chunk| json << chunk }
        json.join
      end

      before { get "/api/v1/publications?chemotion_ids=#{analysis1.id},#{not_existing_chemotion_id}&format=json" }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq expected_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two not existing chemotion_id=0" do
      let(:not_existing_chemotion_id1) { 1 }
      let(:not_existing_chemotion_id2) { 2 }

      before { get "/api/v1/publications?chemotion_ids=#{not_existing_chemotion_id1},#{not_existing_chemotion_id2}&format=json" }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq [].to_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with one invalid chemotion_id" do
      let(:invalid_chemotion_id) { -1 }

      before { get "/api/v1/publications?chemotion_ids=#{analysis1.id},#{invalid_chemotion_id}&format=json" }

      it { expect(response).to have_http_status :bad_request }
      it { expect(JSON.parse(response.body)).to eq({"error" => "chemotion_ids is invalid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two invalid chemotion_ids" do
      let(:invalid_chemotion_id1) { -1 }
      let(:invalid_chemotion_id2) { -2 }

      before { get "/api/v1/publications?chemotion_ids=#{invalid_chemotion_id1},#{invalid_chemotion_id2}&format=json" }

      it { expect(response).to have_http_status :bad_request }
      it { expect(JSON.parse(response.body)).to eq({"error" => "chemotion_ids is invalid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two identical existing chemotion_ids" do
      before { get "/api/v1/publications?chemotion_ids=#{analysis1.id},#{analysis1.id}&format=json" }

      it { expect(response).to have_http_status :bad_request }
      it { expect(JSON.parse(response.body)).to eq({"error" => "chemotion_ids is invalid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end
  end

  describe "GET Analysis" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:attachment) { create(:attachment, :with_realistic_attributes, ana_id: analysis.element_id) }

    let(:expected_json) do
      <<~JSON
        [{
          "@context": "https://schema.org/",
          "@id": "https://dx.doi.org/#{analysis.doi}",
          "@type": "AnalysisEntity",
          "datasetList": #{AnalysisMappers::DataSetListMapper.from_hash(AnalysisAdapter::DataSetListAdapter.new(analysis).to_h).to_json},
          "descriptions": {"ops":[{"insert":" "}, {"attributes":{"script":"super"},"insert":"13"}, {"insert":"C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]},
          "identifier": "#{attachment.analysis.chemotion_id}",
          "ontologies": "#{analysis.kind&.split("|")&.last&.strip}",
          "title": "#{analysis.kind&.split("|")&.last&.strip}",
          "url": "https://dx.doi.org/#{analysis.doi}"
        }]
      JSON
    end

    before { get "/api/v1/publications?chemotion_ids=#{attachment.analysis.id}&format=json" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  describe "GET Reaction" do
    let(:reaction) { create(:reaction, :with_realistic_attributes) }

    let(:expected_json) do
      <<~JSON
         [{
          "@context":"https://schema.org/", 
          "@id":"#{reaction.doi}", 
          "@type":"BioChemicalReaction", 
          "name":"2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine 2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine", 
          "identifier":"#{reaction.chemotion_id}", 
          "status":"#{reaction.reaction_status}", 
          "description":"--- !ruby/hash:Hashie::Mashops:\\n- !ruby/hash:Hashie::Mash\\n  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine\\n    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic\\n    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water\\n    were added. The precipitate was filtered off and washed with water. The crude\\n    product was recrystallized from ethanol to give 106 g of a colorless solid.\\n\\n'\\n", 
          "temperature":"#{reaction.temperature_user_text} #{reaction.temperature_value_unit}", 
          "reactionType":"#{reaction.rxno}", 
          "duration":"#{reaction.reaction_duration}", 
          "purification":"#{(reaction.reaction_purification || []).join(", ")}", 
          "reagentsList":#{ReactionMappers::ReagentsListMapper.from_hash(ReactionAdapter::ReagentsListAdapter.new(reaction).to_h).to_json}
        }]
      JSON
    end

    before do
      create_list(:sample, 2, :with_realistic_attributes, reaction:)

      get "/api/v1/publications?chemotion_ids=#{reaction.id}&format=json"
    end

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  describe "GET Sample" do
    let(:sample) {
      create(:sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [attachments.first.analysis.id, attachments.second.analysis.id],
                        "doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"})
    }
    let(:attachments) { create_list(:attachment, 2, :with_required_dependencies, :with_realistic_attributes) }

    let(:expected_json) do
      <<~JSON
        [{
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
        }]
      JSON
    end

    before { get "/api/v1/publications?chemotion_ids=#{sample.id}&format=json" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end
end
