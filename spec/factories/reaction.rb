FactoryBot.define do
  factory :reaction do
    trait :with_realistic_attributes do
      taggable_data {
        {"doi" => "10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ",
         "license" => "CC BY-SA",
         "creators" => [{"id" => 259, "name" => "Isabelle Wessely", "ORCID" => nil, "givenName" => "Isabelle", "familyName" => "Wessely", "affiliationIds" => [1641]}],
         "queued_at" => "2020-03-17T11:36:56.773+01:00",
         "author_ids" => [259],
         "doi_reg_at" => "2020-03-22T21:39:32.707+01:00",
         "scheme_only" => false,
         "affiliations" => {"1641" => "Institute of Organic Chemistry, KIT, Germany"},
         "contributors" => {"id" => 204, "name" => "Yannick Matt", "ORCID" => nil, "givenName" => "Yannick", "familyName" => "Matt", "affiliations" => ["IOC, Karlsruhe Institute of Technology, Germany"]},
         "published_at" => "2020-03-22T21:39:42.505+01:00",
         "published_by" => 259,
         "affiliation_ids" => [[1641]],
         "products_rinchi" =>
           {"rinchi_string" => "RInChI=1.00.1S/<>C15H11NO2/c17-14-12-8-4-5-9-13(12)15(18)16(14)10-11-6-2-1-3-7-11/h1-9H,10H2/d+",
            "rinchi_web_key" => "[FILTERED]",
            "rinchi_long_key" => "[FILTERED]",
            "rinchi_short_key" => "[FILTERED]"},
         "reaction_version" => 0,
         "original_analysis_ids" => [531186, 531188, 531190]}
      }
      element_type { "Reaction" }
      element_id { 1345 }
      ancestry { nil }
      metadata_xml { # HINT: It is that broken in database.
        <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <resource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://datacite.org/schema/kernel-4" xsi:schemaLocation="http://datacite.org/schema/kernel-4 http://schema.datacite.org/meta/kernel-4.1/metadata.xsd">
            <identifier identifierType="DOI">10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ</identifier>
            <creators>
              <creator>
                <creatorName nameType="Personal">Wessely, Isabelle</creatorName>
                <givenName>Isabelle</givenName>
                <familyName>Wessely</familyName>
                <affiliation>Institute of Organic Chemistry, KIT, Germany</affiliation>
              </creator>
            </creators>
            <titles>
              <title xml:lang="en-US">Short-RInChIKey=SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ</title>
              <title titleType="AlternativeTitle">Short-RInChIKey=SA-BUHFF-WITXFYCLPD-LGRFSURHDF-PTQVIFOWOU-NUHFF-NUHFF-NUHFF-ZZZ</title>
            </titles>
            <publisher>chemotion.net</publisher>
            <publicationYear>2020</publicationYear>
            <contributors>
              <contributor contributorType="Researcher">
                <contributorName>Matt, Yannick</contributorName>
                <givenName>Yannick</givenName>
                <familyName>Matt</familyName>
                <affiliation>IOC, Karlsruhe Institute of Technology, Germany</affiliation>
              </contributor>
            </contributors>
            <dates>
              <date dateType="Created">2020-03-17 10:36:56 UTC</date>
            </dates>
            <subjects>
              <subject>chemical reaction: structures conditions</subject>
            </subjects>
            <language>en</language>
            <resourceType resourceTypeGeneral="Workflow">reaction conditions</resourceType>
            <version>1</version>
            <rightsList>
              <rights xml:lang="en-US" rightsURI="http://creativecommons.org/licenses/by-sa/4.0/">Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)</rights>
            </rightsList>
            <descriptions>
              <description xml:lang="en-US" descriptionType="Abstract">
                2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water were added. The precipitate was filtered off and washed with water. The crude product was recrystallized from ethanol to give 106 g of a colorless solid.
              </description>
            </descriptions>
            <relatedIdentifiers>
              <relatedIdentifier relatedIdentifierType="DOI" relationType="HasPart">10.14272/WITXFYCLPDFRNM-UHFFFAOYSA-N.1</relatedIdentifier>
            </relatedIdentifiers>
          </resource>
        XML
      }
      published_at { "Sun, 22 Mar 2020 20:39:42.505938000 UTC +00:00" }
      doi_suffix { "reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ" }
      extended_metadata { nil }
      reaction_svg_file { "f38c5ef2d6698937d7f96491816d760f894a8a4fbbdfbab0d745613dc7ceddca.svg" }
      reaction_temperature { {"data" => [], "userText" => "118", "valueUnit" => "°C"} }
      reaction_description {
        "--- !ruby/hash:Hashie::Mashops:
- !ruby/hash:Hashie::Mash
  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine
    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic
    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water
    were added. The precipitate was filtered off and washed with water. The crude
    product was recrystallized from ethanol to give 106 g of a colorless solid.

'
"
      }
      reaction_observation {
        "---
ops:
- insert: ''
"
      }
      reaction_duration { "4 Hour(s)" }
      reaction_purification { ["Crystallisation"] }
      tlc_solvents { "" }
      tlc_description { "" }
      reaction_status { "Successful" }
      rinchi_string { "RInChI=1.00.1S/C15H11NO2/c17-14-12-8-4-5-9-13(12)15(18)16(14)10-11-6-2-1-3-7-11/h1-9H,10H2<>C8H4O3/c9-7-5-3-1-2-4-6(5)8(10)11-7/h1-4H<>C2H4O2/c1-2(3)4/h1H3,(H,3,4)!C7H9N/c8-6-7-4-2-1-3-5-7/h1-5H,6,8H2/d-" }
      rinchi_long_key { "[FILTERED]" }
      rinchi_short_key { "[FILTERED]" }
      rinchi_web_key { "[FILTERED]" }
      rxno { "MOP:0000790 | substitution reaction" }
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

    trait :with_realistic_attributes_and_two_authors do
      taggable_data {
        {"doi" => "10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ",
         "license" => "CC BY-SA",
         "creators" => [
           {"id" => 130,
            "name" => "Yu-Chieh Huang",
            "ORCID" => nil,
            "givenName" => "Yu-Chieh",
            "familyName" => "Huang",
            "affiliationIds" => [1537]},
           {"id" => 7,
            "name" => "Simone Gräßle",
            "ORCID" => nil,
            "givenName" => "Simone",
            "familyName" => "Gräßle",
            "affiliationIds" => [15]}
         ],
         "queued_at" => "2020-03-17T11:36:56.773+01:00",
         "author_ids" => [259],
         "doi_reg_at" => "2020-03-22T21:39:32.707+01:00",
         "scheme_only" => false,
         "affiliations" => {"1641" => "Institute of Organic Chemistry, KIT, Germany"},
         "contributors" => {"id" => 204, "name" => "Yannick Matt", "ORCID" => nil, "givenName" => "Yannick", "familyName" => "Matt", "affiliations" => ["IOC, Karlsruhe Institute of Technology, Germany"]},
         "published_at" => "2020-03-22T21:39:42.505+01:00",
         "published_by" => 259,
         "affiliation_ids" => [[1641]],
         "products_rinchi" =>
           {"rinchi_string" => "RInChI=1.00.1S/<>C15H11NO2/c17-14-12-8-4-5-9-13(12)15(18)16(14)10-11-6-2-1-3-7-11/h1-9H,10H2/d+",
            "rinchi_web_key" => "[FILTERED]",
            "rinchi_long_key" => "[FILTERED]",
            "rinchi_short_key" => "[FILTERED]"},
         "reaction_version" => 0,
         "original_analysis_ids" => [531186, 531188, 531190]}
      }
      element_type { "Reaction" }
      element_id { 1345 }
      ancestry { nil }
      metadata_xml { # HINT: It is that broken in database.
        <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <resource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://datacite.org/schema/kernel-4" xsi:schemaLocation="http://datacite.org/schema/kernel-4 http://schema.datacite.org/meta/kernel-4.1/metadata.xsd">
            <identifier identifierType="DOI">10.14272/reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ</identifier>
            <creators>
              <creator>
                <creatorName nameType="Personal">Wessely, Isabelle</creatorName>
                <givenName>Isabelle</givenName>
                <familyName>Wessely</familyName>
                <affiliation>Institute of Organic Chemistry, KIT, Germany</affiliation>
              </creator>
            </creators>
            <titles>
              <title xml:lang="en-US">Short-RInChIKey=SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ</title>
              <title titleType="AlternativeTitle">Short-RInChIKey=SA-BUHFF-WITXFYCLPD-LGRFSURHDF-PTQVIFOWOU-NUHFF-NUHFF-NUHFF-ZZZ</title>
            </titles>
            <publisher>chemotion.net</publisher>
            <publicationYear>2020</publicationYear>
            <contributors>
              <contributor contributorType="Researcher">
                <contributorName>Matt, Yannick</contributorName>
                <givenName>Yannick</givenName>
                <familyName>Matt</familyName>
                <affiliation>IOC, Karlsruhe Institute of Technology, Germany</affiliation>
              </contributor>
            </contributors>
            <dates>
              <date dateType="Created">2020-03-17 10:36:56 UTC</date>
            </dates>
            <subjects>
              <subject>chemical reaction: structures conditions</subject>
            </subjects>
            <language>en</language>
            <resourceType resourceTypeGeneral="Workflow">reaction conditions</resourceType>
            <version>1</version>
            <rightsList>
              <rights xml:lang="en-US" rightsURI="http://creativecommons.org/licenses/by-sa/4.0/">Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)</rights>
            </rightsList>
            <descriptions>
              <description xml:lang="en-US" descriptionType="Abstract">
                2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water were added. The precipitate was filtered off and washed with water. The crude product was recrystallized from ethanol to give 106 g of a colorless solid.
              </description>
            </descriptions>
            <relatedIdentifiers>
              <relatedIdentifier relatedIdentifierType="DOI" relationType="HasPart">10.14272/WITXFYCLPDFRNM-UHFFFAOYSA-N.1</relatedIdentifier>
            </relatedIdentifiers>
          </resource>
        XML
      }
      published_at { "Sun, 22 Mar 2020 20:39:42.505938000 UTC +00:00" }
      doi_suffix { "reaction/SA-FUHFF-UHFFFADPSC-WITXFYCLPD-UHFFFADPSC-NUHFF-NUHFF-NUHFF-ZZZ" }
      extended_metadata { nil }
      reaction_svg_file { "f38c5ef2d6698937d7f96491816d760f894a8a4fbbdfbab0d745613dc7ceddca.svg" }
      reaction_temperature { {"data" => [], "userText" => "118", "valueUnit" => "°C"} }
      reaction_description {
        "--- !ruby/hash:Hashie::Mashops:
- !ruby/hash:Hashie::Mash
  insert: '2-Benzofuran-1,3-dione (75.0 g, 506 mmol, 1.00 equiv) and phenylmethanamine
    (63.9 g, 65.0 mL, 596 mmol, 1.18 equiv) were dissolved in 300 mL glacial acetic
    acid and refluxed for 4 h. After cooling to room temperature, 700 mL of water
    were added. The precipitate was filtered off and washed with water. The crude
    product was recrystallized from ethanol to give 106 g of a colorless solid.

'
"
      }
      reaction_observation {
        "---
ops:
- insert: ''
"
      }
      reaction_duration { "4 Hour(s)" }
      reaction_purification { ["Crystallisation"] }
      tlc_solvents { "" }
      tlc_description { "" }
      reaction_status { "Successful" }
      rinchi_string { "RInChI=1.00.1S/C15H11NO2/c17-14-12-8-4-5-9-13(12)15(18)16(14)10-11-6-2-1-3-7-11/h1-9H,10H2<>C8H4O3/c9-7-5-3-1-2-4-6(5)8(10)11-7/h1-4H<>C2H4O2/c1-2(3)4/h1H3,(H,3,4)!C7H9N/c8-6-7-4-2-1-3-5-7/h1-5H,6,8H2/d-" }
      rinchi_long_key { "[FILTERED]" }
      rinchi_short_key { "[FILTERED]" }
      rinchi_web_key { "[FILTERED]" }
      rxno { "MOP:0000790 | substitution reaction" }
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
