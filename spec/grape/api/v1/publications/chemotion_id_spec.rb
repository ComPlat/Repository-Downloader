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
          "@id": "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
          "@type": "AnalysisEntity",
          "datasetList": {"itemListElement":[{"@type":"DatasetEntity", "Instrument":" Bruker", "attachmentList":{"itemListElement":[{"@type":"AttachmentEntity", "filename":"JK20-proton.peak.png", "filepath":"data/#{attachment.analysis.chemotion_id}", "identifier":"6954c6ca-adef-4ab1-b00b-31dbf9c53c8a"}], "numberOfItems":1}, "descriptions":"", "identifier":"681160", "name":"R53A_EI-MS"}], "numberOfItems":1},
          "descriptions": {"ops":[{"insert":" "}, {"attributes":{"script":"super"},"insert":"13"}, {"insert":"C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]},
          "identifier": "#{attachment.analysis.chemotion_id}",
          "ontologies": "13C nuclear magnetic resonance spectroscopy (13C NMR)",
          "title": "13C nuclear magnetic resonance spectroscopy (13C NMR)",
          "url": "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1"
        }
      JSON
    end

    before { get "/api/v1/publications/chemotion_id/#{attachment.analysis.id}" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  describe "GET Sample" do
    let(:sample) {
      create :sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [attachment1.analysis.id, attachment2.analysis.id]}
    }
    let(:attachment1) { create :attachment, :with_required_dependencies, :with_realistic_attributes }
    let(:attachment2) { create :attachment, :with_required_dependencies, :with_realistic_attributes }

    let(:expected_json) do
      <<~JSON
        {
          "@context": "https://schema.org/",
          "@id": "",
          "@type": "MolecularEntity",
          "analysisList": {"itemListElement":[{"@context":"https://schema.org/", "@id":"", "@type":"AnalysisEntity", "datasetList":{"itemListElement":[{"@type":"DatasetEntity", "Instrument":" Bruker", "attachmentList":{"itemListElement":[{"@type":"AttachmentEntity", "filename":"JK20-proton.peak.png", "filepath":"data/#{attachment1.analysis.chemotion_id}", "identifier":"6954c6ca-adef-4ab1-b00b-31dbf9c53c8a"}], "numberOfItems":1}, "descriptions":"", "identifier":"681160", "name":"R53A_EI-MS"}], "numberOfItems":1}, "descriptions":{}, "identifier":"#{attachment1.analysis.chemotion_id}", "ontologies":"", "title":"", "url":""}, {"@context":"https://schema.org/", "@id":"", "@type":"AnalysisEntity", "datasetList":{"itemListElement":[{"@type":"DatasetEntity", "Instrument":" Bruker", "attachmentList":{"itemListElement":[{"@type":"AttachmentEntity", "filename":"JK20-proton.peak.png", "filepath":"data/#{attachment2.analysis.chemotion_id}", "identifier":"6954c6ca-adef-4ab1-b00b-31dbf9c53c8a"}], "numberOfItems":1}, "descriptions":"", "identifier":"681160", "name":"R53A_EI-MS"}], "numberOfItems":1}, "descriptions":{}, "identifier":"#{attachment2.analysis.chemotion_id}", "ontologies":"", "title":"", "url":""}], "numberOfItems":2},
          "boilingPoint": "-Infinity...Infinity",
          "dct:conformsTo": {"http://purl.org/dc/terms/conformsTo":{"@id":"https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE", "@type":"CreativeWork"}},
          "identifier": "#{sample.chemotion_id}",
          "inChI": "InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)",
          "inChIKey": "MUAMZYSBUQADBN-UHFFFAOYSA-N",
          "iupacName": "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
          "meltingPoint": "-Infinity...Infinity",
          "molecularFormula": "C20H14N8",
          "molecularWeight": {"value":366.37876000000006},
          "name": "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
          "smiles": "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1",
          "url": "https://dx.doi.org/"
        }
      JSON
    end

    before { get "/api/v1/publications/chemotion_id/#{sample.id}" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end
end
