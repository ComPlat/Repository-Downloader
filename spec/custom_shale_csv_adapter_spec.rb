# frozen_string_literal: true

require "custom_shale_csv_adapter"

describe CustomShaleCsvAdapter do
  describe ".new" do
    subject(:new) { described_class.new }

    it { expect(new).to be_a described_class }
  end

  describe ".dump" do
    subject(:dump) { described_class.dump(obj_array_of_hashes, headers:) }

    let(:obj_array_of_hashes) {
      [{"context" => "context",
        "type" => "type",
        "id" => "id",
        "ontologies" => "ontologies",
        "title" => "title",
        "descriptions" => "descriptions",
        "url" => "url",
        "identifier" => "identifier",
        "datasetList" => "datasetList"},
        {"context" => "https://schema.org/",
         "type" => "AnalysisEntity",
         "id" => "https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595",
         "ontologies" => nil,
         "title" => "13C nuclear magnetic resonance spectroscopy (13C NMR) (4-(2-oxo-2-phenylacetyl)benzoic acid)",
         "descriptions" => nil,
         "url" => "https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595",
         "identifier" => "CRD-27923",
         "datasetList" =>
           {"numberOfItems" => 1,
            "itemListElement" =>
              [{"type" => "DatasetEntity",
                "identifier" => "12345",
                "name" => "BJ68_1H",
                "Instrument" => "Bruker 400 MHz",
                "descriptions" => "Bruker 400 MHz",
                "attachmentList" => {
                  "numberOfItems" => 2,
                  "itemListElement" =>
                    [{"type" => "AttachmentEntity",
                      "identifier" => "a63e278b-22f2-4da3-955f-e80e197bc853",
                      "filename" => "BJ68_1H.zip",
                      "filepath" => "data/a63e278b-22f2-4da3-955f-e80e197bc853"},
                      {"type" => "AttachmentEntity",
                       "identifier" => "a63e278b-22f2-4da3-955f-e80e197bc853",
                       "filename" => "HRMS.jpg",
                       "filepath" => "data/a63e278b-22f2-4da3-955f-e80e197bc853"}]
                }}]}}]
    }
    let(:headers) { %w[context type id ontologies title descriptions url identifier datasetList] }

    let(:expected_csv) do
      <<~CSV
        context,type,id,ontologies,title,descriptions,url,identifier,datasetList.numberOfItems,datasetList.itemListElement1.type,datasetList.itemListElement1.identifier,datasetList.itemListElement1.name,datasetList.itemListElement1.Instrument,datasetList.itemListElement1.descriptions,datasetList.itemListElement1.attachmentList.numberOfItems,datasetList.itemListElement1.attachmentList.itemListElement1.type,datasetList.itemListElement1.attachmentList.itemListElement1.identifier,datasetList.itemListElement1.attachmentList.itemListElement1.filename,datasetList.itemListElement1.attachmentList.itemListElement1.filepath,datasetList.itemListElement1.attachmentList.itemListElement2.type,datasetList.itemListElement1.attachmentList.itemListElement2.identifier,datasetList.itemListElement1.attachmentList.itemListElement2.filename,datasetList.itemListElement1.attachmentList.itemListElement2.filepath
        https://schema.org/,AnalysisEntity,https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595,,13C nuclear magnetic resonance spectroscopy (13C NMR) (4-(2-oxo-2-phenylacetyl)benzoic acid),,https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595,CRD-27923,1,DatasetEntity,12345,BJ68_1H,Bruker 400 MHz,Bruker 400 MHz,2,AttachmentEntity,a63e278b-22f2-4da3-955f-e80e197bc853,BJ68_1H.zip,data/a63e278b-22f2-4da3-955f-e80e197bc853,AttachmentEntity,a63e278b-22f2-4da3-955f-e80e197bc853,HRMS.jpg,data/a63e278b-22f2-4da3-955f-e80e197bc853
      CSV
    end

    it { is_expected.to eq expected_csv }
  end
end
