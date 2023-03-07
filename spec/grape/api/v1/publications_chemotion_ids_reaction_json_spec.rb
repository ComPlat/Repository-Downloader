describe API::V1::Publications, ".chemotion_ids .reaction" do
  context "when one reaction and no attachments" do
    let(:reaction) { create(:reaction, :with_realistic_attributes) }

    let(:expected_json) do
      [{
        "@context": "https://schema.org/",
        "@id": "10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ",
        "@type": "BioChemicalReaction",
        name: "",
        identifier: reaction.chemotion_id.to_s,
        status: "Successful",
        description: "--- !ruby/hash:Hashie::Mashops:\n- !ruby/hash:Hashie::Mash\n  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine\n    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic\n    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water\n    were added. The precipitate was filtered off and washed with water. The crude\n    product was recrystallized from ethanol to give 106 g of a colorless solid.\n\n'\n",
        temperature: "118 °C",
        reactionType: "MOP:0000790 | substitution reaction",
        duration: "4 Hour(s)",
        purification: "Crystallisation",
        reagentsList: {"itemListElement" => [], "numberOfItems" => 0}
      }].to_json
    end

    before { get "/api/v1/publications?chemotion_ids=#{reaction.id}&format=json" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  context "when one reaction and one attachment" do
    let(:reaction) { create(:reaction, :with_realistic_attributes) }
    let(:attached_sample1) { create(:sample, :with_realistic_attributes, reaction:) }

    let(:expected_reagents_list_json) do
      {"itemListElement" => [
         {
           "@id" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
           "@type" => "MolecularEntity",
           "dct:conformsTo" => {
             "@id" => "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/",
             "@type" => "CreativeWork"
           },
           "identifier" => "CRS-#{attached_sample1.id}",
           "inChIKey" => "MUAMZYSBUQADBN-UHFFFAOYSA-N",
           "molecularFormula" => "C20H14N8",
           "name" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
           "smiles" => "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1"
         }
       ],
       "numberOfItems" => 1}
    end
    let(:expected_json) do
      [{
        "@context": "https://schema.org/",
        "@id": "10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ",
        "@type": "BioChemicalReaction",
        name: "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
        identifier: reaction.chemotion_id.to_s,
        status: "Successful",
        description: "--- !ruby/hash:Hashie::Mashops:\n- !ruby/hash:Hashie::Mash\n  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine\n    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic\n    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water\n    were added. The precipitate was filtered off and washed with water. The crude\n    product was recrystallized from ethanol to give 106 g of a colorless solid.\n\n'\n",
        temperature: "118 °C",
        reactionType: "MOP:0000790 | substitution reaction",
        duration: "4 Hour(s)",
        purification: "Crystallisation",
        reagentsList: expected_reagents_list_json
      }].to_json
    end

    before do
      attached_sample1
      get "/api/v1/publications?chemotion_ids=#{reaction.id}&format=json"
    end

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  context "when one reaction and two attachments" do
    let(:reaction) { create(:reaction, :with_realistic_attributes) }
    let(:attached_samples) { create_list(:sample, 2, :with_realistic_attributes, reaction:) }

    let(:expected_reagents_list_json) do
      {
        "itemListElement" => [
          {
            "@id" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
            "@type" => "MolecularEntity",
            "dct:conformsTo" => {
              "@id" => "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/",
              "@type" => "CreativeWork"
            },
            "identifier" => attached_samples.first.chemotion_id.to_s,
            "inChIKey" => "MUAMZYSBUQADBN-UHFFFAOYSA-N",
            "molecularFormula" => "C20H14N8",
            "name" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
            "smiles" => "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1"
          },
          {
            "@id" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
            "@type" => "MolecularEntity",
            "dct:conformsTo" => {
              "@id" => "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/",
              "@type" => "CreativeWork"
            },
            "identifier" => attached_samples.second.chemotion_id.to_s,
            "inChIKey" => "MUAMZYSBUQADBN-UHFFFAOYSA-N",
            "molecularFormula" => "C20H14N8",
            "name" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
            "smiles" => "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1"
          }
        ],
        "numberOfItems" => 2
      }
    end
    let(:expected_json) do
      [{
        "@context": "https://schema.org/",
        "@id": "10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ",
        "@type": "BioChemicalReaction",
        name: "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine 2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
        identifier: reaction.chemotion_id.to_s,
        status: "Successful",
        description: "--- !ruby/hash:Hashie::Mashops:\n- !ruby/hash:Hashie::Mash\n  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine\n    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic\n    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water\n    were added. The precipitate was filtered off and washed with water. The crude\n    product was recrystallized from ethanol to give 106 g of a colorless solid.\n\n'\n",
        temperature: "118 °C",
        reactionType: "MOP:0000790 | substitution reaction",
        duration: "4 Hour(s)",
        purification: "Crystallisation",
        reagentsList: expected_reagents_list_json
      }].to_json
    end

    before do
      attached_samples
      get "/api/v1/publications?chemotion_ids=#{reaction.id}&format=json"
    end

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end
end
