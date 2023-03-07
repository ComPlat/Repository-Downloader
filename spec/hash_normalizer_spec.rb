# frozen_string_literal: true

require "hash_normalizer"

describe HashNormalizer do
  let(:hash_input) {
    {"context" => "https://schema.org/",
     "type" => "AnalysisEntity",
     "id" => "https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595",
     "ontologies" => "13C nuclear magnetic resonance spectroscopy (13C NMR)",
     "title" => "13C nuclear magnetic resonance spectroscopy (13C NMR) (4-(2-oxo-2-phenylacetyl)benzoic acid)",
     "descriptions" => "{'ops':[{'insert':' '};{'attributes':{'script':'super'};'insert':'13'};{'insert':'C NMR (100 MHz; DMSO-d6; ppm); δ = 171.0; 141.1; 135.4 (q; J = 5.2 Hz); 127.4; 124.3 (q; J = 4.2 Hz); 124.0 (q; J = 271.3 Hz); 118.9; 118.2; 111.3 (q; J = 33.3 Hz); 44.4; 25.6; 22.3 (2 C). '}]}", "url" => "https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595",
     "identifier" => "CRD-27923",
     "datasetList" =>
       {"numberOfItems" => 1,
        "itemListElement" =>
          [{"type" => "DatasetEntity",
            "identifier" => "12345",
            "name" => "BJ68_1H",
            "Instrument" => "Bruker 400 MHz",
            "descriptions" => "Bruker 400 MHz",
            "attachmentList" =>
              {"numberOfItems" => 2,
               "itemListElement" =>
                 [{"type" => "AttachmentEntity",
                   "identifier" => "a63e278b-22f2-4da3-955f-e80e197bc853",
                   "filename" => "BJ68_1H.zip",
                   "filepath" => "data/a63e278b-22f2-4da3-955f-e80e197bc853"},
                   {"type" => "AttachmentEntity",
                    "identifier" => "a63e278b-22f2-4da3-955f-e80e197bc853",
                    "filename" => "HRMS.jpg",
                    "filepath" => "data/a63e278b-22f2-4da3-955f-e80e197bc853"}]}}]}}
  }

  describe ".new" do
    subject(:new) { described_class.new(hash_input) }

    it { expect(new).to be_a described_class }
  end

  describe "#normalized_hash" do
    subject { described_class.new(hash_input).normalized_hash }

    let(:expected_hash) {
      {"context" => "https://schema.org/",
       "type" => "AnalysisEntity",
       "id" => "https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595",
       "ontologies" => "13C nuclear magnetic resonance spectroscopy (13C NMR)",
       "title" => "13C nuclear magnetic resonance spectroscopy (13C NMR) (4-(2-oxo-2-phenylacetyl)benzoic acid)",
       "descriptions" => "{'ops':[{'insert':' '};{'attributes':{'script':'super'};'insert':'13'};{'insert':'C NMR (100 MHz; DMSO-d6; ppm); δ = 171.0; 141.1; 135.4 (q; J = 5.2 Hz); 127.4; 124.3 (q; J = 4.2 Hz); 124.0 (q; J = 271.3 Hz); 118.9; 118.2; 111.3 (q; J = 33.3 Hz); 44.4; 25.6; 22.3 (2 C). '}]}", "url" => "https://dx.doi.org/10.14272/MWJHDSAAGSURCA-UHFFFAOYSA-N/CHMO0000595",
       "identifier" => "CRD-27923",
       "datasetList.numberOfItems" => 1,
       "datasetList.itemListElement1.Instrument" => "Bruker 400 MHz",
       "datasetList.itemListElement1.attachmentList.itemListElement1.filename" => "BJ68_1H.zip",
       "datasetList.itemListElement1.attachmentList.itemListElement1.filepath" => "data/a63e278b-22f2-4da3-955f-e80e197bc853",
       "datasetList.itemListElement1.attachmentList.itemListElement1.identifier" => "a63e278b-22f2-4da3-955f-e80e197bc853",
       "datasetList.itemListElement1.attachmentList.itemListElement1.type" => "AttachmentEntity",
       "datasetList.itemListElement1.attachmentList.itemListElement2.filename" => "HRMS.jpg",
       "datasetList.itemListElement1.attachmentList.itemListElement2.filepath" => "data/a63e278b-22f2-4da3-955f-e80e197bc853",
       "datasetList.itemListElement1.attachmentList.itemListElement2.identifier" => "a63e278b-22f2-4da3-955f-e80e197bc853",
       "datasetList.itemListElement1.attachmentList.itemListElement2.type" => "AttachmentEntity",
       "datasetList.itemListElement1.attachmentList.numberOfItems" => 2,
       "datasetList.itemListElement1.descriptions" => "Bruker 400 MHz",
       "datasetList.itemListElement1.identifier" => "12345",
       "datasetList.itemListElement1.name" => "BJ68_1H",
       "datasetList.itemListElement1.type" => "DatasetEntity"}
    }

    it { is_expected.to eq(expected_hash) }
  end
end
