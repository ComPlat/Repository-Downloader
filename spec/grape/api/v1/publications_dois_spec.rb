describe API::V1::Publications, ".dois" do
  let(:analysis1) { create(:analysis, :with_realistic_attributes) }
  let(:reaction1) { create(:reaction, :with_realistic_attributes) }

  describe "GET /api/v1/publications?dois={analysis1.doi}&format=json" do
    context "with existing doi" do
      before { get "/api/v1/publications?dois=#{analysis1.doi}&format=json" }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq PublicationsByDoiPresenter.new([analysis1.id]).to_json.to_a.join }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with NOT existing dois" do
      let(:not_existing_doi) { "10.24790/not_existing_doi" }

      before { get "/api/v1/publications?dois=#{not_existing_doi}&format=json" }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq [].to_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with NOT existing and invalid dois" do
      let(:invalid_doi) { "invalid_doi" }

      before { get "/api/v1/publications?dois=#{invalid_doi}&format=json" }

      it { expect(response).to have_http_status :bad_request }
      it { expect(JSON.parse(response.body)).to eq({"error" => "dois is invalid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end
  end

  describe "GET /api/v1/publications?dois={analysis1.doi},{analysis2.doi}&format=json" do
    context "with two existing dois" do
      before { get "/api/v1/publications?dois=#{analysis1.doi},#{reaction1.doi}&format=json" }

      let(:expected_json) do
        PublicationsByDoiPresenter.new([analysis1.doi, reaction1.doi]).to_json.to_a.join
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq expected_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with one not existing doi" do
      let(:not_existing_doi) { "10.24790/not_existing_doi" }

      before { get "/api/v1/publications?dois=#{analysis1.doi},#{not_existing_doi}&format=json" }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq PublicationsByDoiPresenter.new([analysis1.id]).to_json.to_a.join }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two not existing dois" do
      let(:not_existing_doi1) { "10.24790/not_existing_doi" }
      let(:not_existing_doi2) { "10.24791/not_existing_doi" }

      before { get "/api/v1/publications?dois=#{not_existing_doi1},#{not_existing_doi2}&format=json" }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq [].to_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with one invalid doi" do
      let(:invalid_doi) { "invalid_doi" }

      before { get "/api/v1/publications?dois=#{analysis1.id},#{invalid_doi}&format=json" }

      it { expect(response).to have_http_status :bad_request }
      it { expect(JSON.parse(response.body)).to eq({"error" => "dois is invalid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two invalid dois" do
      let(:invalid_doi1) { "invalid_doi1" }
      let(:invalid_doi2) { "invalid_doi2" }

      before { get "/api/v1/publications?dois=#{invalid_doi1},#{invalid_doi2}&format=json" }

      it { expect(response).to have_http_status :bad_request }
      it { expect(JSON.parse(response.body)).to eq({"error" => "dois is invalid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two identical existing dois" do
      before { get "/api/v1/publications?dois=#{analysis1.doi},#{analysis1.doi}&format=json" }

      it { expect(response).to have_http_status :bad_request }
      it { expect(JSON.parse(response.body)).to eq({"error" => "dois is invalid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end
  end

  xdescribe "GET Analysis" do
    let!(:analysis) { create(:analysis, :with_realistic_attributes) }
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

    before { get "/api/v1/publications?dois=#{analysis.doi}&format=json" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  describe "GET Reaction" do
    let(:reaction) { create(:reaction, :with_realistic_attributes) }
    let(:attached_sample1) { create(:sample, :with_realistic_attributes, reaction:) }
    let(:attached_sample2) { create(:sample, :with_realistic_attributes, reaction:) }

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
      attached_sample1
      attached_sample2
      get "/api/v1/publications?dois=#{reaction.doi}&format=json"
    end

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  describe "GET Sample" do
    let(:sample) {
      create(:sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [attachment1.analysis.id, attachment2.analysis.id],
                        "doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"})
    }
    let(:attachment1) { create(:attachment, :with_required_dependencies, :with_realistic_attributes) }
    let(:attachment2) { create(:attachment, :with_required_dependencies, :with_realistic_attributes) }

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

    before { get "/api/v1/publications?dois=#{sample.doi}&format=json" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end
end
