describe API::V1::Publications, ".chemotion_ids .analysis" do
  context "when one analysis and no attachments" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }

    let(:expected_json) do
      [{
        "@context": "https://schema.org/",
        "@id": "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
        "@type": "AnalysisEntity",
        datasetList: {"itemListElement" => [], "numberOfItems" => 0},
        descriptions: {ops: [{insert: " "}, {attributes: {script: "super"}, insert: "13"}, {insert: "C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]},
        identifier: analysis.chemotion_id.to_s,
        ontologies: "13C nuclear magnetic resonance spectroscopy (13C NMR)",
        title: "13C nuclear magnetic resonance spectroscopy (13C NMR)",
        url: "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1"
      }].to_json
    end

    before { get "/api/v1/publications?chemotion_ids=#{analysis.id}&format=json" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  context "when one analysis and one attachment" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:attachment) { create(:attachment, :with_realistic_attributes, ana_id: analysis.element_id) }

    let(:expected_data_set_list_json) {
      {"itemListElement" => [
         {
           "@type" => "DatasetEntity",
           "Instrument" => " Bruker",
           "attachmentList" => {
             "itemListElement" => [
               {
                 "@type" => "AttachmentEntity",
                 "filename" => "JK20-proton.peak.png",
                 "filepath" => "data/CRD-#{analysis.id}",
                 "identifier" => "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a"
               }
             ],
             "numberOfItems" => 1
           },
           "descriptions" => "",
           "identifier" => "681160",
           "name" => "R53A_EI-MS"
         }
       ],
       "numberOfItems" => 1}
    }

    let(:expected_json) do
      [{
        "@context": "https://schema.org/",
        "@id": "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
        "@type": "AnalysisEntity",
        datasetList: expected_data_set_list_json,
        descriptions: {ops: [{insert: " "}, {attributes: {script: "super"}, insert: "13"}, {insert: "C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]},
        identifier: analysis.chemotion_id.to_s,
        ontologies: "13C nuclear magnetic resonance spectroscopy (13C NMR)",
        title: "13C nuclear magnetic resonance spectroscopy (13C NMR)",
        url: "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1"
      }].to_json
    end

    before do
      attachment
      get "/api/v1/publications?chemotion_ids=#{analysis.id}&format=json"
    end

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  context "when one analysis and two attachments" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:attachments) {
      [create(:attachment, :with_realistic_attributes, ana_id: analysis.element_id),
        create(:attachment, :with_realistic_attributes, ana_id: analysis.element_id)]
    }

    let(:expected_data_set_list_json) {
      {"itemListElement" => [
         {
           "@type" => "DatasetEntity",
           "Instrument" => " Bruker",
           "attachmentList" => {
             "itemListElement" => [
               {
                 "@type" => "AttachmentEntity",
                 "filename" => "JK20-proton.peak.png",
                 "filepath" => "data/CRD-#{analysis.id}",
                 "identifier" => "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a"
               },
               {
                 "@type" => "AttachmentEntity",
                 "filename" => "JK20-proton.peak.png",
                 "filepath" => "data/CRD-#{analysis.id}",
                 "identifier" => "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a"
               }
             ],
             "numberOfItems" => 2
           },
           "descriptions" => "",
           "identifier" => "681160",
           "name" => "R53A_EI-MS"
         }
       ],
       "numberOfItems" => 2}
    }

    let(:expected_json) do
      [{
        "@context": "https://schema.org/",
        "@id": "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
        "@type": "AnalysisEntity",
        datasetList: expected_data_set_list_json,
        descriptions: {ops: [{insert: " "}, {attributes: {script: "super"}, insert: "13"}, {insert: "C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]},
        identifier: analysis.chemotion_id.to_s,
        ontologies: "13C nuclear magnetic resonance spectroscopy (13C NMR)",
        title: "13C nuclear magnetic resonance spectroscopy (13C NMR)",
        url: "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1"
      }].to_json
    end

    before do
      attachments
      get "/api/v1/publications?chemotion_ids=#{analysis.id}&format=json"
    end

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end
end
