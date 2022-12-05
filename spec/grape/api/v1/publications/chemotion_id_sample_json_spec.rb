describe API::V1::Publications::ChemotionId, ".sample" do
  context "when one sample and no analyses and no attachments" do
    let(:sample) {
      create :sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [],
                        "doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}
    }

    let(:expected_json) do
      {"@context" => "https://schema.org/",
       "@id" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
       "@type" => "MolecularEntity",
       "analysisList" => {"itemListElement" => [], "numberOfItems" => 0},
       "boilingPoint" => "-Infinity...Infinity",
       "dct:conformsTo" => {"http://purl.org/dc/terms/conformsTo" => {"@id" => "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/", "@type" => "CreativeWork"}},
       "identifier" => "CRS-#{sample.id}",
       "inChI" => "InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)",
       "inChIKey" => "MUAMZYSBUQADBN-UHFFFAOYSA-N",
       "iupacName" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
       "meltingPoint" => "-Infinity...Infinity",
       "molecularFormula" => "C20H14N8",
       "molecularWeight" => {"value" => 366.37876000000006},
       "name" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
       "smiles" => "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1",
       "url" => "https://dx.doi.org/10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}.to_json
    end

    before { get "/api/v1/publications/chemotion_id/#{sample.id}" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  context "when one sample and one analysis and no attachments" do
    let(:sample) {
      create :sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [analysis.id],
                        "doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}
    }
    let(:analysis) { create :analysis, :with_realistic_attributes }

    let(:expected_analysis_list_json) {
      {
        "itemListElement" => [
          {"@context" => "https://schema.org/",
           "@id" => "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
           "@type" => "AnalysisEntity",
           "datasetList" => {
             "itemListElement" => [],
             "numberOfItems" => 0
           },
           "descriptions" => {
             "ops" => [
               {"insert" => " "},
               {"attributes" => {"script" => "super"},
                "insert" => "13"},
               {"insert" => "C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}
             ]
           },
           "identifier" => "CRD-#{analysis.id}",
           "ontologies" => "13C nuclear magnetic resonance spectroscopy (13C NMR)", "title" => "13C nuclear magnetic resonance spectroscopy (13C NMR)",
           "url" => "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1"}
        ],
        "numberOfItems" => 1
      }
    }

    let(:expected_json) do
      {"@context" => "https://schema.org/",
       "@id" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
       "@type" => "MolecularEntity",
       "analysisList" => expected_analysis_list_json,
       "boilingPoint" => "-Infinity...Infinity",
       "dct:conformsTo" => {"http://purl.org/dc/terms/conformsTo" => {"@id" => "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/", "@type" => "CreativeWork"}},
       "identifier" => "CRS-#{sample.id}",
       "inChI" => "InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)",
       "inChIKey" => "MUAMZYSBUQADBN-UHFFFAOYSA-N",
       "iupacName" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
       "meltingPoint" => "-Infinity...Infinity",
       "molecularFormula" => "C20H14N8",
       "molecularWeight" => {"value" => 366.37876000000006},
       "name" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
       "smiles" => "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1",
       "url" => "https://dx.doi.org/10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}.to_json
    end

    before { get "/api/v1/publications/chemotion_id/#{sample.id}" }

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  context "when one sample and one analysis and one attachment" do
    let(:sample) {
      create :sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [analysis.id],
                        "doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}
    }
    let(:analysis) { create :analysis, :with_realistic_attributes }
    let(:attachment) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id }

    let(:expected_analysis_list_json) {
      expected_data_set_list = {
        "itemListElement" => [
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
        "numberOfItems" => 1
      }

      {
        "itemListElement" => [
          {"@context" => "https://schema.org/",
           "@id" => "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
           "@type" => "AnalysisEntity",
           "datasetList" => expected_data_set_list,
           "descriptions" => {
             "ops" => [
               {"insert" => " "},
               {"attributes" => {"script" => "super"},
                "insert" => "13"},
               {"insert" => "C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}
             ]
           },
           "identifier" => "CRD-#{analysis.id}",
           "ontologies" => "13C nuclear magnetic resonance spectroscopy (13C NMR)", "title" => "13C nuclear magnetic resonance spectroscopy (13C NMR)",
           "url" => "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1"}
        ],
        "numberOfItems" => 1
      }
    }

    let(:expected_json) do
      {"@context" => "https://schema.org/",
       "@id" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
       "@type" => "MolecularEntity",
       "analysisList" => expected_analysis_list_json,
       "boilingPoint" => "-Infinity...Infinity",
       "dct:conformsTo" => {"http://purl.org/dc/terms/conformsTo" => {"@id" => "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/", "@type" => "CreativeWork"}},
       "identifier" => "CRS-#{sample.id}",
       "inChI" => "InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)",
       "inChIKey" => "MUAMZYSBUQADBN-UHFFFAOYSA-N",
       "iupacName" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
       "meltingPoint" => "-Infinity...Infinity",
       "molecularFormula" => "C20H14N8",
       "molecularWeight" => {"value" => 366.37876000000006},
       "name" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
       "smiles" => "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1",
       "url" => "https://dx.doi.org/10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}.to_json
    end

    before do
      attachment
      get "/api/v1/publications/chemotion_id/#{sample.id}"
    end

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end

  context "when one sample and two analyses and two attachments for each analysis" do
    let(:sample) {
      create :sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [analyses.first.id, analyses.second.id],
                        "doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}
    }
    let(:analyses) {
      [(create :analysis, :with_realistic_attributes, element_id: 1),
        (create :analysis, :with_realistic_attributes, element_id: 2)]
    }
    let(:attachments) {
      [(create :attachment, :with_realistic_attributes, ana_id: analyses.first.element_id),
        (create :attachment, :with_realistic_attributes, ana_id: analyses.first.element_id),
        (create :attachment, :with_realistic_attributes, ana_id: analyses.second.element_id),
        (create :attachment, :with_realistic_attributes, ana_id: analyses.second.element_id)]
    }

    let(:expected_analysis_list_json) {
      expected_data_set_list_1 = {
        "itemListElement" => [
          {
            "@type" => "DatasetEntity",
            "Instrument" => " Bruker",
            "attachmentList" => {
              "itemListElement" => [
                {
                  "@type" => "AttachmentEntity",
                  "filename" => "JK20-proton.peak.png",
                  "filepath" => "data/CRD-#{analyses.first.id}",
                  "identifier" => "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a"
                },
                {
                  "@type" => "AttachmentEntity",
                  "filename" => "JK20-proton.peak.png",
                  "filepath" => "data/CRD-#{analyses.first.id}",
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
        "numberOfItems" => 2
      }

      expected_data_set_list_2 = {
        "itemListElement" => [
          {
            "@type" => "DatasetEntity",
            "Instrument" => " Bruker",
            "attachmentList" => {
              "itemListElement" => [
                {
                  "@type" => "AttachmentEntity",
                  "filename" => "JK20-proton.peak.png",
                  "filepath" => "data/CRD-#{analyses.second.id}",
                  "identifier" => "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a"
                },
                {
                  "@type" => "AttachmentEntity",
                  "filename" => "JK20-proton.peak.png",
                  "filepath" => "data/CRD-#{analyses.second.id}",
                  "identifier" => "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a"
                }
              ],
              "numberOfItems" => 2
            },
            "descriptions" => "",
            "identifier" => "681160", "name" => "R53A_EI-MS"
          }
        ],
        "numberOfItems" => 2
      }

      {
        "itemListElement" => [
          {
            "@context" => "https://schema.org/",
            "@id" => "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
            "@type" => "AnalysisEntity",
            "datasetList" => expected_data_set_list_1,
            "descriptions" => {
              "ops" => [
                {
                  "insert" => " "
                },
                {
                  "attributes" => {
                    "script" => "super"
                  },
                  "insert" => "13"
                },
                {"insert" => "C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}
              ]
            },
            "identifier" => "CRD-#{analyses.first.id}",
            "ontologies" => "13C nuclear magnetic resonance spectroscopy (13C NMR)",
            "title" => "13C nuclear magnetic resonance spectroscopy (13C NMR)",
            "url" => "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1"
          },
          {
            "@context" => "https://schema.org/",
            "@id" => "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
            "@type" => "AnalysisEntity",
            "datasetList" => expected_data_set_list_2,
            "descriptions" => {
              "ops" => [
                {
                  "insert" => " "
                },
                {
                  "attributes" => {
                    "script" => "super"
                  },
                  "insert" => "13"
                },
                {
                  "insert" => "C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "
                }
              ]
            },
            "identifier" => "CRD-#{analyses.second.id}",
            "ontologies" => "13C nuclear magnetic resonance spectroscopy (13C NMR)",
            "title" => "13C nuclear magnetic resonance spectroscopy (13C NMR)",
            "url" => "https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1"
          }
        ],
        "numberOfItems" => 2
      }
    }

    let(:expected_json) do
      {"@context" => "https://schema.org/",
       "@id" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
       "@type" => "MolecularEntity",
       "analysisList" => expected_analysis_list_json,
       "boilingPoint" => "-Infinity...Infinity",
       "dct:conformsTo" => {"http://purl.org/dc/terms/conformsTo" => {"@id" => "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/", "@type" => "CreativeWork"}},
       "identifier" => "CRS-#{sample.id}",
       "inChI" => "InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)",
       "inChIKey" => "MUAMZYSBUQADBN-UHFFFAOYSA-N",
       "iupacName" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
       "meltingPoint" => "-Infinity...Infinity",
       "molecularFormula" => "C20H14N8",
       "molecularWeight" => {"value" => 366.37876000000006},
       "name" => "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine",
       "smiles" => "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1",
       "url" => "https://dx.doi.org/10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}.to_json
    end

    before do
      attachments
      get "/api/v1/publications/chemotion_id/#{sample.id}"
    end

    it { expect(JSON.parse(response.body)).to eq JSON.parse(expected_json) }
  end
end
