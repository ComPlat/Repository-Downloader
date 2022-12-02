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

  describe "GET Reaction" do
    let(:reaction) { create :reaction, :with_realistic_attributes }
    let(:attached_sample1) { create :sample, :with_realistic_attributes, reaction:, id: 2 }
    let(:attached_sample2) { create :sample, :with_realistic_attributes, reaction:, id: 3 }

    let(:expected_json) do
      <<~JSON
        {
          "@context":"https://schema.org/", 
          "@id":"10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ", 
          "@type":"BioChemicalReaction", 
          "name":"2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine 2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine", 
          "identifier":"#{reaction.chemotion_id}", 
          "status":"Successful", 
          "description":"--- !ruby/hash:Hashie::Mashops:\\n- !ruby/hash:Hashie::Mash\\n  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine\\n    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic\\n    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water\\n    were added. The precipitate was filtered off and washed with water. The crude\\n    product was recrystallized from ethanol to give 106 g of a colorless solid.\\n\\n'\\n", 
          "temperature":"118 °C", 
          "reactionType":"MOP:0000790 | substitution reaction", 
          "duration":"4 Hour(s)", 
          "purification":"Crystallisation", 
          "reagentsList": {"numberOfItems":2, "itemListElement":[{"@type":"MolecularEntity", "dct:conformsTo":{"@type":"CreativeWork", "@id":"https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/"}, "@id":"10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1", "identifier":"CRS-2", "name":"2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine", "molecularFormula":"C20H14N8", "inChIKey":"MUAMZYSBUQADBN-UHFFFAOYSA-N", "smiles":"c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1"}, {"@type":"MolecularEntity", "dct:conformsTo":{"@type":"CreativeWork", "@id":"https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/"}, "@id":"10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1", "identifier":"CRS-3", "name":"2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine", "molecularFormula":"C20H14N8", "inChIKey":"MUAMZYSBUQADBN-UHFFFAOYSA-N", "smiles":"c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1"}]}
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
end
