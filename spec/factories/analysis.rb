FactoryBot.define do
  factory :analysis do
    trait :with_realistic_attributes do
      id { 2913 }
      taggable_data {
        {"doi" => "10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N",
         "creators" =>
           [{"id" => 2,
             "name" => "Nicole Jung",
             "orcid" => nil,
             "givenName" => "Nicole",
             "familyName" => "Jung",
             "affiliationIds" => [15]},
             {"id" => 89,
              "name" => "Ana María García",
              "orcid" => nil,
              "givenName" => "Ana María",
              "familyName" => "García",
              "affiliationIds" => [15]}],
         "queued_at" => nil,
         "author_ids" => [2, 89],
         "chem_first" => nil,
         "doi_reg_at" => nil,
         "affiliations" =>
           {"15" => "Stefan Bräse Group, Institute of Organic Chemistry, Karlsruhe Institute of Technology, Germany"},
         "analysis_doi" => "10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1",
         "published_at" => "2015-06-09T16:13:14.012Z",
         "published_by" => 2,
         "pubchem_reg_at" => nil,
         "sample_version" => nil,
         "dataset_version" => "1"}
      }
      element_type { "Container" }
      element_id { "6620" }
      ancestry { "2912" }
      metadata_xml { # HINT: It is that broken in database.
        <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <resource xsi:schemaLocation="http://datacite.org/schema/kernel-3 http://schema.datacite.org/meta/kernel-3/metadata.xsd" 
                    xmlns="http://datacite.org/schema/kernel-3" 
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
              <identifier identifierType="DOI">10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1</identifier>
              <creators>
                <creator>
                <creatorName>Nicole Jung</creatorName>
                </creator>
                <creator>
                <creatorName>Ana María García</creatorName>
                </creator>
              </creators>
              <titles>
                <title>NMR/13C/DMSO/100 (3-methyl-N-(7-(trifluoromethyl)-1H-indazol-3-yl)butanamide)</title>
              </titles>
              <publisher>chemotion.net</publisher>
              <publicationYear>2015</publicationYear>
              <subjects>
                <subject>Chemistry</subject>
              </subjects>
              <language>eng</language>
              <contributors>
                <contributor contributorType="ResearchGroup">
                  <contributorName>Karlsruhe Institute of Technology, Institute of Organic Chemistry (Stefan Bräse Group)</contributorName>
                </contributor>
                <contributor contributorType="ResearchGroup">
                  <contributorName>KIT, IOC (AK Bräse)</contributorName>
                </contributor>
              </contributors>
              <resourceType resourceTypeGeneral="Dataset">Dataset</resourceType>
              <version>1</version>
              <descriptions>
                <description descriptionType="Abstract">This is a dataset.</description>
              </descriptions>
              <relatedIdentifiers>
                <relatedIdentifier relatedIdentifierType="DOI" relationType="IsPartOf">10.14272/YCYKSCMNYXMYQE-UHFFFAOYSA-N</relatedIdentifier>
              </relatedIdentifiers>
          </resource>
        XML
      }
      published_at { "Tue, 09 Jun 2015 16:13:14.012000000 UTC +00:00" }
      doi_suffix { "YCYKSCMNYXMYQE-UHFFFAOYSA-N/NMR/13C/DMSO/100.1" }
      extended_metadata {
        {"kind" => "CHMO:0000595 | 13C nuclear magnetic resonance spectroscopy (13C NMR)",
         "content" =>
           "{\"ops\":[{\"insert\":\" \"}, {\"attributes\":{\"script\":\"super\"},\"insert\":\"13\"}, {\"insert\":\"C NMR (100 MHz, DMSO-d6, ppm), δ = 171.0, 141.1, 135.4 (q, J = 5.2 Hz), 127.4, 124.3 (q, J = 4.2 Hz), 124.0 (q, J = 271.3 Hz), 118.9, 118.2, 111.3 (q, J = 33.3 Hz), 44.4, 25.6, 22.3 (2 C). \"}]}",
         "'method'" => "'NMR/13C/DMSO/100'",
         "'report'" => "'false'"}
      }
      reaction_svg_file { nil }
      reaction_temperature { nil }
      reaction_description { nil }
      reaction_observation { nil }
      reaction_duration { nil }
      reaction_purification { nil }
      tlc_solvents { nil }
      tlc_description { nil }
      reaction_status { nil }
      rinchi_string { nil }
      rinchi_long_key { nil }
      rinchi_short_key { nil }
      rinchi_web_key { nil }
      rxno { nil }
      sample_svg_file { nil }
      molfile { nil }
      sample_desc { nil }
      sample_melting_point { nil }
      sample_boiling_point { nil }
      target_amount_value { nil }
      target_amount_unit { nil }
      rs_type { nil }
      add_attribute(:yield) { nil }
      iupac_name { nil }
      cano_smiles { nil }
      sum_formular { nil }
      inchikey { nil }
      inchistring { nil }
      molecular_weight { nil }
    end
  end
end
