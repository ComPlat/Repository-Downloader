describe API::V1::Publications, ".chemotion_ids .reaction" do
  context "when one reaction and no attachments" do
    let(:reaction) { create(:reaction, :with_realistic_attributes) }

    let(:expected_xml) do
      <<~XML
        <publications>
          <reaction>
            <context>https://schema.org/</context>
            <id>10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ</id>
            <type>BioChemicalReaction</type>
            <name/>
            <identifier>CRR-#{reaction.id}</identifier>
            <status>Successful</status>
            <description>--- !ruby/hash:Hashie::Mashops:- !ruby/hash:Hashie::Mash\n  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine\n    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic\n    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water\n    were added. The precipitate was filtered off and washed with water. The crude\n    product was recrystallized from ethanol to give 106 g of a colorless solid.\n\n'\n</description>
            <temperature>118 &#xB0;C</temperature>
            <reaction_type>MOP:0000790 | substitution reaction</reaction_type>
            <duration>4 Hour(s)</duration>
            <purification>Crystallisation</purification>
            <reagents_list>
              <numberOfItems>0</numberOfItems>
            </reagents_list>
          </reaction>
         </publications>
      XML
    end

    before { get "/api/v1/publications?chemotion_ids=#{reaction.id}&format=xml" }

    it { expect(Hash.from_xml(response.parsed_body)).to eq(Hash.from_xml(expected_xml)) }
  end

  context "when one reaction and one attachment" do
    let(:reaction) { create(:reaction, :with_realistic_attributes) }
    let(:attached_sample) { create(:sample, :with_realistic_attributes, reaction:, id: 2) }

    let(:expected_reagents_list_xml) do
      <<~XML
        <numberOfItems>1</numberOfItems>
        <itemListElement>
          <type>MolecularEntity</type>
          <dct_conformsTo>
            <type>CreativeWork</type>
            <id>https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/</id>
          </dct_conformsTo>
          <id>10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</id>
          <identifier>CRS-#{attached_sample.id}</identifier>
          <name>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</name>
          <molecularFormula>C20H14N8</molecularFormula>
          <inChIKey>MUAMZYSBUQADBN-UHFFFAOYSA-N</inChIKey>
          <smiles>c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1</smiles>
        </itemListElement>
      XML
    end
    let(:expected_xml) do
      <<~XML
        <publications>        
          <reaction>
            <context>https://schema.org/</context>
            <id>10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ</id>
            <type>BioChemicalReaction</type>
            <name>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</name>
            <identifier>CRR-#{reaction.id}</identifier>
            <status>Successful</status>
            <description>--- !ruby/hash:Hashie::Mashops:- !ruby/hash:Hashie::Mash\n  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine\n    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic\n    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water\n    were added. The precipitate was filtered off and washed with water. The crude\n    product was recrystallized from ethanol to give 106 g of a colorless solid.\n\n'\n</description>
            <temperature>118 &#xB0;C</temperature>
            <reaction_type>MOP:0000790 | substitution reaction</reaction_type>
            <duration>4 Hour(s)</duration>
            <purification>Crystallisation</purification>
            <reagents_list>
              #{expected_reagents_list_xml}
            </reagents_list>
          </reaction>
        </publications>
      XML
    end

    before do
      attached_sample
      get "/api/v1/publications?chemotion_ids=#{reaction.id}&format=xml"
    end

    it { expect(Hash.from_xml(response.parsed_body)).to eq(Hash.from_xml(expected_xml)) }
  end

  context "when one reaction and two attachments" do
    let(:reaction) { create(:reaction, :with_realistic_attributes) }
    let(:attachted_samples) {
      [create(:sample, :with_realistic_attributes, reaction:, id: 2),
        create(:sample, :with_realistic_attributes, reaction:, id: 3)]
    }

    let(:expected_reagents_list_xml) do
      <<~XML
        <numberOfItems>2</numberOfItems>
        <itemListElement>
          <type>MolecularEntity</type>
          <dct_conformsTo>
            <type>CreativeWork</type>
            <id>https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/</id>
          </dct_conformsTo>
        <id>10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</id>
        <identifier>CRS-#{attachted_samples.first.id}</identifier>
        <name>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</name>
        <molecularFormula>C20H14N8</molecularFormula>
        <inChIKey>MUAMZYSBUQADBN-UHFFFAOYSA-N</inChIKey>
        <smiles>c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1</smiles>
        </itemListElement>
        <itemListElement>
          <type>MolecularEntity</type>
          <dct_conformsTo>
            <type>CreativeWork</type>
            <id>https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/</id>
          </dct_conformsTo>
          <id>10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</id>
          <identifier>CRS-#{attachted_samples.second.id}</identifier>
          <name>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</name>
          <molecularFormula>C20H14N8</molecularFormula>
          <inChIKey>MUAMZYSBUQADBN-UHFFFAOYSA-N</inChIKey>
          <smiles>c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1</smiles>
        </itemListElement>
      XML
    end
    let(:expected_xml) do
      <<~XML
        <publications>
          <reaction>
            <context>https://schema.org/</context>
            <id>10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ</id>
            <type>BioChemicalReaction</type>
            <name>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine 2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</name>
            <identifier>CRR-#{reaction.id}</identifier>
            <status>Successful</status>
            <description>--- !ruby/hash:Hashie::Mashops:- !ruby/hash:Hashie::Mash\n  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine\n    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic\n    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water\n    were added. The precipitate was filtered off and washed with water. The crude\n    product was recrystallized from ethanol to give 106 g of a colorless solid.\n\n'\n</description>
            <temperature>118 &#xB0;C</temperature>
            <reaction_type>MOP:0000790 | substitution reaction</reaction_type>
            <duration>4 Hour(s)</duration>
            <purification>Crystallisation</purification>
            <reagents_list>
              #{expected_reagents_list_xml}
            </reagents_list>
          </reaction>
        </publications>
      XML
    end

    before do
      attachted_samples
      get "/api/v1/publications?chemotion_ids=#{reaction.id}&format=xml"
    end

    it { expect(Hash.from_xml(response.parsed_body)).to eq(Hash.from_xml(expected_xml)) }
  end
end
