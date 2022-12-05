describe API::V1::Publications::ChemotionId, ".sample" do
  context "when one sample and no analyses and no attachments" do
    let(:sample) {
      create :sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [],
                        "doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}
    }

    let(:expected_xml) do
      <<~XML
        <sample>
          <context>https://schema.org/</context>
          <type>MolecularEntity</type>
          <dct_conformsTo>
            <dct_conformsTo>
              <type>CreativeWork</type>
              <id>https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/</id>
            </dct_conformsTo>
          </dct_conformsTo>
          <id>10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</id>
          <name>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</name>
          <url>https://dx.doi.org/10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</url>
          <identifier>CRS-#{sample.id}</identifier>
          <iupacName>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</iupacName>
          <smiles>c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1</smiles>
          <inChI>InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)</inChI>
          <inChIKey>MUAMZYSBUQADBN-UHFFFAOYSA-N</inChIKey>
          <molecularFormula>C20H14N8</molecularFormula>
          <meltingPoint>-Infinity...Infinity</meltingPoint>
          <boilingPoint>-Infinity...Infinity</boilingPoint>
          <molecularWeight><value>366.37876000000006</value></molecularWeight>
          <analysisList>
            <numberOfItems>0</numberOfItems>
          </analysisList>
        </sample>
      XML
    end

    before { get "/api/v1/publications/chemotion_id/#{sample.id}.xml" }

    it { expect(response.parsed_body).to eq_without_whitespace expected_xml }
  end

  context "when one sample and one analysis and no attachments" do
    let(:sample) {
      create :sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [analysis.id],
                        "doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}
    }
    let(:analysis) { create :analysis, :with_realistic_attributes }

    let(:expected_analysis_list_xml) {
      <<~XML
        <numberOfItems>1</numberOfItems>
        <itemListElement>
          <context>https://schema.org/</context>
          <type>AnalysisEntity</type>
          <id>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</id>
          <ontologies>13C nuclear magnetic resonance spectroscopy (13C NMR)</ontologies>
          <title>13C nuclear magnetic resonance spectroscopy (13C NMR)</title>
          <descriptions>{"ops"=&gt;[{"insert"=&gt;"&#xA0;"}, {"attributes"=&gt;{"script"=&gt;"super"}, "insert"=&gt;"13"}, {"insert"=&gt;"C NMR (100 MHz, DMSO-d6, ppm), &#x3B4; = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]}</descriptions>
          <url>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</url>
          <identifier>CRD-#{analysis.id}</identifier>
          <datasetList>
            <numberOfItems>0</numberOfItems>
          </datasetList>
        </itemListElement>
      XML
    }

    let(:expected_xml) do
      <<~XML
        <sample>
          <context>https://schema.org/</context>
          <type>MolecularEntity</type>
          <dct_conformsTo>
            <dct_conformsTo>
              <type>CreativeWork</type>
              <id>https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/</id>
            </dct_conformsTo>
          </dct_conformsTo>
          <id>10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</id>
          <name>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</name>
          <url>https://dx.doi.org/10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</url>
          <identifier>CRS-#{sample.id}</identifier>
          <iupacName>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</iupacName>
          <smiles>c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1</smiles>
          <inChI>InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)</inChI>
          <inChIKey>MUAMZYSBUQADBN-UHFFFAOYSA-N</inChIKey>
          <molecularFormula>C20H14N8</molecularFormula>
          <meltingPoint>-Infinity...Infinity</meltingPoint>
          <boilingPoint>-Infinity...Infinity</boilingPoint>
          <molecularWeight><value>366.37876000000006</value></molecularWeight>
          <analysisList>
            #{expected_analysis_list_xml}
          </analysisList>
        </sample>
      XML
    end

    before { get "/api/v1/publications/chemotion_id/#{sample.id}.xml" }

    it { expect(response.parsed_body).to eq_without_whitespace expected_xml }
  end

  context "when one sample and one analysis and one attachment" do
    let(:sample) {
      create :sample, :with_required_dependencies, :with_realistic_attributes,
        taggable_data: {"original_analysis_ids" => [analysis.id],
                        "doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1"}
    }
    let(:analysis) { create :analysis, :with_realistic_attributes }
    let(:attachment) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id }

    let(:expected_analysis_list_xml) {
      expected_data_set_list =
        <<~XML
          <numberOfItems>1</numberOfItems>
          <itemListElement>
            <type>DatasetEntity</type>
            <identifier>681160</identifier>
            <name>R53A_EI-MS</name>
            <Instrument> Bruker</Instrument>
            <descriptions/>
            <attachmentList>
            <numberOfItems>1</numberOfItems>
            <itemListElement>
              <type>AttachmentEntity</type>
              <identifier>6954c6ca-adef-4ab1-b00b-31dbf9c53c8a</identifier>
              <filename>JK20-proton.peak.png</filename>
              <filepath>data/CRD-#{analysis.id}</filepath>
            </itemListElement>
            </attachmentList>
          </itemListElement>
        XML

      <<~XML
        <numberOfItems>1</numberOfItems>
        <itemListElement>
          <context>https://schema.org/</context>
          <type>AnalysisEntity</type>
          <id>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</id>
          <ontologies>13C nuclear magnetic resonance spectroscopy (13C NMR)</ontologies>
          <title>13C nuclear magnetic resonance spectroscopy (13C NMR)</title>
          <descriptions>{"ops"=&gt;[{"insert"=&gt;"&#xA0;"}, {"attributes"=&gt;{"script"=&gt;"super"}, "insert"=&gt;"13"}, {"insert"=&gt;"C NMR (100 MHz, DMSO-d6, ppm), &#x3B4; = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]}</descriptions>
          <url>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</url>
          <identifier>CRD-#{analysis.id}</identifier>
          <datasetList>
            #{expected_data_set_list}
          </datasetList>
        </itemListElement>
      XML
    }

    let(:expected_xml) do
      <<~XML
        <sample>
          <context>https://schema.org/</context>
          <type>MolecularEntity</type>
          <dct_conformsTo>
            <dct_conformsTo>
              <type>CreativeWork</type>
              <id>https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/</id>
            </dct_conformsTo>
          </dct_conformsTo>
          <id>10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</id>
          <name>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</name>
          <url>https://dx.doi.org/10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</url>
          <identifier>CRS-#{sample.id}</identifier>
          <iupacName>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</iupacName>
          <smiles>c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1</smiles>
          <inChI>InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)</inChI>
          <inChIKey>MUAMZYSBUQADBN-UHFFFAOYSA-N</inChIKey>
          <molecularFormula>C20H14N8</molecularFormula>
          <meltingPoint>-Infinity...Infinity</meltingPoint>
          <boilingPoint>-Infinity...Infinity</boilingPoint>
          <molecularWeight><value>366.37876000000006</value></molecularWeight>
          <analysisList>
            #{expected_analysis_list_xml}
          </analysisList>
        </sample>
      XML
    end

    before do
      attachment
      get "/api/v1/publications/chemotion_id/#{sample.id}.xml"
    end

    it { expect(response.parsed_body).to eq_without_whitespace expected_xml }
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

    let(:expected_analysis_list_xml) {
      expected_data_set_list_1 =
        <<~XML
          <numberOfItems>2</numberOfItems>
          <itemListElement>
            <type>DatasetEntity</type>
            <identifier>681160</identifier>
            <name>R53A_EI-MS</name>
            <Instrument> Bruker</Instrument>
            <descriptions/>
            <attachmentList>
              <numberOfItems>2</numberOfItems>
              <itemListElement>
                <type>AttachmentEntity</type>
                <identifier>6954c6ca-adef-4ab1-b00b-31dbf9c53c8a</identifier>
                <filename>JK20-proton.peak.png</filename>
                <filepath>data/CRD-#{analyses.first.id}</filepath>
              </itemListElement>
              <itemListElement>
                <type>AttachmentEntity</type>
                <identifier>6954c6ca-adef-4ab1-b00b-31dbf9c53c8a</identifier>
                <filename>JK20-proton.peak.png</filename>
                <filepath>data/CRD-#{analyses.first.id}</filepath>
              </itemListElement>
            </attachmentList>
          </itemListElement>
        XML

      expected_data_set_list_2 =
        <<~XML
          <numberOfItems>2</numberOfItems>
          <itemListElement>
            <type>DatasetEntity</type>
            <identifier>681160</identifier>
            <name>R53A_EI-MS</name>
            <Instrument> Bruker</Instrument>
            <descriptions/>
            <attachmentList>
              <numberOfItems>2</numberOfItems>
              <itemListElement>
                <type>AttachmentEntity</type>
                <identifier>6954c6ca-adef-4ab1-b00b-31dbf9c53c8a</identifier>
                <filename>JK20-proton.peak.png</filename>
                <filepath>data/CRD-#{analyses.second.id}</filepath>
              </itemListElement>
              <itemListElement>
                <type>AttachmentEntity</type>
                <identifier>6954c6ca-adef-4ab1-b00b-31dbf9c53c8a</identifier>
                <filename>JK20-proton.peak.png</filename>
                <filepath>data/CRD-#{analyses.second.id}</filepath>
              </itemListElement>
            </attachmentList>
          </itemListElement>
        XML

      <<~XML
        <numberOfItems>2</numberOfItems>
        <itemListElement>
          <context>https://schema.org/</context>
          <type>AnalysisEntity</type>
          <id>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</id>
          <ontologies>13C nuclear magnetic resonance spectroscopy (13C NMR)</ontologies>
          <title>13C nuclear magnetic resonance spectroscopy (13C NMR)</title>
          <descriptions>{"ops"=&gt;[{"insert"=&gt;"&#xA0;"}, {"attributes"=&gt;{"script"=&gt;"super"}, "insert"=&gt;"13"}, {"insert"=&gt;"C NMR (100 MHz, DMSO-d6, ppm), &#x3B4; = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]}</descriptions>
          <url>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</url>
          <identifier>CRD-#{analyses.first.id}</identifier>
          <datasetList>
            #{expected_data_set_list_1}
          </datasetList>
        </itemListElement>
        <itemListElement>
          <context>https://schema.org/</context>
          <type>AnalysisEntity</type>
          <id>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</id>
          <ontologies>13C nuclear magnetic resonance spectroscopy (13C NMR)</ontologies>
          <title>13C nuclear magnetic resonance spectroscopy (13C NMR)</title>
          <descriptions>{"ops"=&gt;[{"insert"=&gt;"&#xA0;"}, {"attributes"=&gt;{"script"=&gt;"super"}, "insert"=&gt;"13"}, {"insert"=&gt;"C NMR (100 MHz, DMSO-d6, ppm), &#x3B4; = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]}</descriptions>
          <url>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</url>
          <identifier>CRD-#{analyses.second.id}</identifier>
          <datasetList>
            #{expected_data_set_list_2}
          </datasetList>
        </itemListElement>
      XML
    }

    let(:expected_xml) do
      <<~XML
        <sample>
          <context>https://schema.org/</context>
          <type>MolecularEntity</type>
          <dct_conformsTo>
            <dct_conformsTo>
              <type>CreativeWork</type>
              <id>https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE/</id>
            </dct_conformsTo>
          </dct_conformsTo>
          <id>10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</id>
          <name>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</name>
          <url>https://dx.doi.org/10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</url>
          <identifier>CRS-#{sample.id}</identifier>
          <iupacName>2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine</iupacName>
          <smiles>c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1</smiles>
          <inChI>InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)</inChI>
          <inChIKey>MUAMZYSBUQADBN-UHFFFAOYSA-N</inChIKey>
          <molecularFormula>C20H14N8</molecularFormula>
          <meltingPoint>-Infinity...Infinity</meltingPoint>
          <boilingPoint>-Infinity...Infinity</boilingPoint>
          <molecularWeight><value>366.37876000000006</value></molecularWeight>
          <analysisList>
            #{expected_analysis_list_xml}
          </analysisList>
        </sample>
      XML
    end

    before do
      attachments
      get "/api/v1/publications/chemotion_id/#{sample.id}.xml"
    end

    it { expect(response.parsed_body).to eq_without_whitespace expected_xml }
  end
end
