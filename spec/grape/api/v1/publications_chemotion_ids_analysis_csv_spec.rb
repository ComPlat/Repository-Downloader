describe API::V1::Publications, ".chemotion_ids .analysis" do
  context "when one analysis and no attachments" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }

    let(:expected_csv) do
      <<~CSV
        context,type,id,ontologies,title,descriptions,url,identifier,datasetList.numberOfItems
        https://schema.org/,AnalysisEntity,https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1,13C nuclear magnetic resonance spectroscopy (13C NMR),13C nuclear magnetic resonance spectroscopy (13C NMR),{'ops':[{'insert':' '};{'attributes':{'script':'super'};'insert':'13'};{'insert':'C NMR (100 MHz; DMSO-d6; ppm); δ = 171.0; 141.1; 135.4 (q; J = 5.2 Hz); 127.4; 124.3 (q; J = 4.2 Hz); 124.0 (q; J = 271.3 Hz); 118.9; 118.2; 111.3 (q; J = 33.3 Hz); 44.4; 25.6; 22.3 (2 C). '}]},https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1,CRD-#{analysis.id},0
      CSV
    end

    before { get "/api/v1/publications?chemotion_ids=#{analysis.id}&format=csv" }

    it { expect(response.body).to eq expected_csv }
  end

  context "when two analyses and no attachments" do
    let(:analyses) { create_list(:analysis, 2, :with_realistic_attributes) }

    let(:expected_csv) do
      <<~CSV
        context,type,id,ontologies,title,descriptions,url,identifier,datasetList.numberOfItems
        https://schema.org/,AnalysisEntity,https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1,13C nuclear magnetic resonance spectroscopy (13C NMR),13C nuclear magnetic resonance spectroscopy (13C NMR),{'ops':[{'insert':' '};{'attributes':{'script':'super'};'insert':'13'};{'insert':'C NMR (100 MHz; DMSO-d6; ppm); δ = 171.0; 141.1; 135.4 (q; J = 5.2 Hz); 127.4; 124.3 (q; J = 4.2 Hz); 124.0 (q; J = 271.3 Hz); 118.9; 118.2; 111.3 (q; J = 33.3 Hz); 44.4; 25.6; 22.3 (2 C). '}]},https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1,CRD-#{analyses.first.id},0
        https://schema.org/,AnalysisEntity,https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1,13C nuclear magnetic resonance spectroscopy (13C NMR),13C nuclear magnetic resonance spectroscopy (13C NMR),{'ops':[{'insert':' '};{'attributes':{'script':'super'};'insert':'13'};{'insert':'C NMR (100 MHz; DMSO-d6; ppm); δ = 171.0; 141.1; 135.4 (q; J = 5.2 Hz); 127.4; 124.3 (q; J = 4.2 Hz); 124.0 (q; J = 271.3 Hz); 118.9; 118.2; 111.3 (q; J = 33.3 Hz); 44.4; 25.6; 22.3 (2 C). '}]},https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1,CRD-#{analyses.second.id},0
      CSV
    end

    before { get "/api/v1/publications?chemotion_ids=#{analyses.first.id},#{analyses.second.id}&format=csv" }

    it { expect(response.body).to eq expected_csv }
  end

  context "when one analysis and one attachment" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:attachment) { create(:attachment, :with_realistic_attributes, ana_id: analysis.element_id) }

    let(:expected_csv) do
      <<~CSV
        context,type,id,ontologies,title,descriptions,url,identifier,datasetList.numberOfItems,datasetList.itemListElement1.type,datasetList.itemListElement1.identifier,datasetList.itemListElement1.name,datasetList.itemListElement1.Instrument,datasetList.itemListElement1.descriptions,datasetList.itemListElement1.attachmentList.numberOfItems,datasetList.itemListElement1.attachmentList.itemListElement1.type,datasetList.itemListElement1.attachmentList.itemListElement1.identifier,datasetList.itemListElement1.attachmentList.itemListElement1.filename,datasetList.itemListElement1.attachmentList.itemListElement1.filepath
        https://schema.org/,AnalysisEntity,https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1,13C nuclear magnetic resonance spectroscopy (13C NMR),13C nuclear magnetic resonance spectroscopy (13C NMR),{'ops':[{'insert':' '};{'attributes':{'script':'super'};'insert':'13'};{'insert':'C NMR (100 MHz; DMSO-d6; ppm); δ = 171.0; 141.1; 135.4 (q; J = 5.2 Hz); 127.4; 124.3 (q; J = 4.2 Hz); 124.0 (q; J = 271.3 Hz); 118.9; 118.2; 111.3 (q; J = 33.3 Hz); 44.4; 25.6; 22.3 (2 C). '}]},https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1,CRD-#{analysis.id},1,DatasetEntity,681160,R53A_EI-MS, Bruker,"",1,AttachmentEntity,6954c6ca-adef-4ab1-b00b-31dbf9c53c8a,JK20-proton.peak.png,data/CRD-#{analysis.id}
      CSV
    end

    before do
      attachment
      get "/api/v1/publications?chemotion_ids=#{analysis.id}&format=csv"
    end

    it { expect(response.body).to eq expected_csv }
  end

  context "when one analysis and two attachments" do
    let(:analysis) { create(:analysis, :with_realistic_attributes) }
    let(:attachments) {
      [create(:attachment, :with_realistic_attributes, ana_id: analysis.element_id),
        create(:attachment, :with_realistic_attributes, ana_id: analysis.element_id)]
    }

    let(:expected_csv) do
      <<~CSV
        context,type,id,ontologies,title,descriptions,url,identifier,datasetList.numberOfItems,datasetList.itemListElement1.type,datasetList.itemListElement1.identifier,datasetList.itemListElement1.name,datasetList.itemListElement1.Instrument,datasetList.itemListElement1.descriptions,datasetList.itemListElement1.attachmentList.numberOfItems,datasetList.itemListElement1.attachmentList.itemListElement1.type,datasetList.itemListElement1.attachmentList.itemListElement1.identifier,datasetList.itemListElement1.attachmentList.itemListElement1.filename,datasetList.itemListElement1.attachmentList.itemListElement1.filepath,datasetList.itemListElement1.attachmentList.itemListElement2.type,datasetList.itemListElement1.attachmentList.itemListElement2.identifier,datasetList.itemListElement1.attachmentList.itemListElement2.filename,datasetList.itemListElement1.attachmentList.itemListElement2.filepath
        https://schema.org/,AnalysisEntity,https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1,13C nuclear magnetic resonance spectroscopy (13C NMR),13C nuclear magnetic resonance spectroscopy (13C NMR),{'ops':[{'insert':' '};{'attributes':{'script':'super'};'insert':'13'};{'insert':'C NMR (100 MHz; DMSO-d6; ppm); δ = 171.0; 141.1; 135.4 (q; J = 5.2 Hz); 127.4; 124.3 (q; J = 4.2 Hz); 124.0 (q; J = 271.3 Hz); 118.9; 118.2; 111.3 (q; J = 33.3 Hz); 44.4; 25.6; 22.3 (2 C). '}]},https://dx.doi.org/10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1,CRD-#{analysis.id},2,DatasetEntity,681160,R53A_EI-MS, Bruker,"",2,AttachmentEntity,6954c6ca-adef-4ab1-b00b-31dbf9c53c8a,JK20-proton.peak.png,data/CRD-#{analysis.id},AttachmentEntity,6954c6ca-adef-4ab1-b00b-31dbf9c53c8a,JK20-proton.peak.png,data/CRD-#{analysis.id}
      CSV
    end

    before do
      attachments
      get "/api/v1/publications?chemotion_ids=#{analysis.id}&format=csv"
    end

    it { expect(response.body).to eq expected_csv }
  end
end
