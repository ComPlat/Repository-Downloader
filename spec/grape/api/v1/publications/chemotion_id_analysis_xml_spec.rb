describe API::V1::Publications::ChemotionId, ".analysis" do
  context "when one analysis and no attachments" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }

    let(:expected_xml) do
      <<~XML
        <analysis>
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
        </analysis>
      XML
    end

    before { get "/api/v1/publications/chemotion_id/#{analysis.id}.xml" }

    it { expect(response.parsed_body).to eq_without_whitespace expected_xml }
  end

  context "when one analysis and one attachment" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:attachment) { create :attachment, :with_realistic_attributes, ana_id: analysis.element_id }

    let(:expected_data_set_list_xml) do
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
    end

    let(:expected_xml) do
      <<~XML
        <analysis>
          <context>https://schema.org/</context>
          <type>AnalysisEntity</type>
          <id>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</id>
          <ontologies>13C nuclear magnetic resonance spectroscopy (13C NMR)</ontologies>
          <title>13C nuclear magnetic resonance spectroscopy (13C NMR)</title>
          <descriptions>{"ops"=&gt;[{"insert"=&gt;"&#xA0;"}, {"attributes"=&gt;{"script"=&gt;"super"}, "insert"=&gt;"13"}, {"insert"=&gt;"C NMR (100 MHz, DMSO-d6, ppm), &#x3B4; = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]}</descriptions>
          <url>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</url>
          <identifier>CRD-#{analysis.id}</identifier>
          <datasetList>
            #{expected_data_set_list_xml}
          </datasetList>
        </analysis>
      XML
    end

    before do
      attachment
      get "/api/v1/publications/chemotion_id/#{analysis.id}.xml"
    end

    it { expect(response.parsed_body).to eq_without_whitespace expected_xml }
  end

  context "when one analysis and two attachments" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:attachments) {
      [(create :attachment, :with_realistic_attributes, ana_id: analysis.element_id),
        (create :attachment, :with_realistic_attributes, ana_id: analysis.element_id)]
    }

    let(:expected_data_set_list_xml) do
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
              <filepath>data/CRD-#{analysis.id}</filepath>
            </itemListElement>
            <itemListElement>
              <type>AttachmentEntity</type>
              <identifier>6954c6ca-adef-4ab1-b00b-31dbf9c53c8a</identifier>
              <filename>JK20-proton.peak.png</filename>
              <filepath>data/CRD-#{analysis.id}</filepath>
            </itemListElement>
          </attachmentList>
        </itemListElement>
      XML
    end

    let(:expected_xml) do
      <<~XML
        <analysis>
          <context>https://schema.org/</context>
          <type>AnalysisEntity</type>
          <id>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</id>
          <ontologies>13C nuclear magnetic resonance spectroscopy (13C NMR)</ontologies>
          <title>13C nuclear magnetic resonance spectroscopy (13C NMR)</title>
          <descriptions>{"ops"=&gt;[{"insert"=&gt;"&#xA0;"}, {"attributes"=&gt;{"script"=&gt;"super"}, "insert"=&gt;"13"}, {"insert"=&gt;"C NMR (100 MHz, DMSO-d6, ppm), &#x3B4; = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). "}]}</descriptions>
          <url>https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</url>
          <identifier>CRD-#{analysis.id}</identifier>
          <datasetList>
            #{expected_data_set_list_xml}
          </datasetList>
        </analysis>
      XML
    end

    before do
      attachments
      get "/api/v1/publications/chemotion_id/#{analysis.id}.xml"
    end

    it { expect(response.parsed_body).to eq_without_whitespace expected_xml }
  end
end
