FactoryBot.define do
  factory :sample do
    trait :with_required_dependencies do
      reaction { create(:reaction) }
    end

    trait :with_realistic_attributes do
      taggable_data {
        {"doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
         "sid" => "384636332",
         "creators" => [{"id" => 130,
                         "name" => "Yu-Chieh Huang",
                         "ORCID" => nil,
                         "givenName" => "Yu-Chieh",
                         "familyName" => "Huang",
                         "affiliationIds" => [1537]}],
         "queued_at" => "2019-06-27T15:58:15.129+02:00",
         "author_ids" => [130],
         "chem_first" => "2019-06-27T21:01:09.781+02:00",
         "doi_reg_at" => "2019-06-27T21:01:09.781+02:00",
         "affiliations" => {"1537" => "Institute of Toxicology and Genetics, Karlsruhe Institute of Technology, Germany"},
         "analysis_ids" => [499476],
         "published_at" => "2019-06-27T21:01:12.455+02:00",
         "published_by" => 130,
         "pubchem_reg_at" => "2019-06-27T21:01:12.414+02:00",
         "sample_version" => 1,
         "affiliation_ids" => [[1537]],
         "original_analysis_ids" => [495836]}
      }
      element_type { "Sample" }
      element_id { 43961 }
      metadata_xml { # HINT: It is that broken in database.
        <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <resource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://datacite.org/schema/kernel-4" xsi:schemaLocation="http://datacite.org/schema/kernel-4 http://schema.datacite.org/meta/kernel-4.1/metadata.xsd">
            <identifier identifierType="DOI">10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</identifier>
            <creators>
              <creator>
                <creatorName nameType="Personal">Huang, Yu-Chieh</creatorName>
                <givenName>Yu-Chieh</givenName>
                <familyName>Huang</familyName>
                  <affiliation>Institute of Toxicology and Genetics, Karlsruhe Institute of Technology, Germany</affiliation>
              </creator>
            </creators>
            <titles>
              <title xml:lang="en-US">C20H14N8</title>
              <title titleType="AlternativeTitle">InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)</title>
            </titles>
            <publisher>chemotion.net</publisher>
            <publicationYear>2019</publicationYear>
            <dates>
            <date dateType="Created">2019-06-27 13:58:50 UTC</date>
            </dates>
            <subjects>
              <subject>Chemistry</subject>
            </subjects>
            <language>en</language>
            <resourceType resourceTypeGeneral="Dataset">Molecule</resourceType>
            <version>1</version>
            <descriptions>
              <description xml:lang="en-US" descriptionType="Abstract">
                This dataset contains experimental data from a sample (InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)).<br />
                The datasets from the following experiments are available:<br />
                
                      IR<br />
                
              </description>
            </descriptions>
            <relatedIdentifiers>
              <relatedIdentifier relatedIdentifierType="DOI" relationType="HasPart">10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N/IR</relatedIdentifier>
            </relatedIdentifiers>
          </resource>
        XML
      }
      published_at { "Thu, 27 Jun 2019 19:01:12.455291000 UTC +00:00" }
      doi_suffix { "MUAMZYSBUQADBN-UHFFFAOYSA-N.1" }
      extended_metadata { nil }
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
      sample_svg_file { "bf6a432662c34510bf77006c2db915f9be86a1a626255ddb07fdec5849d49a093ad8a2db7fd29a522f8f0b49d05740c8409a085283c5d47d3821daad374edf8e.svg" }
      molfile { "\n  -ISIS-  03031715412D\n\n 28 32  0  0  0  0  0  0  0  0999 V2000\n    9.3167  -13.8083    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    9.3333  -14.4083    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    9.8625  -14.6917    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   10.3750  -14.3792    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   10.3542  -13.7792    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    9.8250  -13.4958    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    8.6708  -14.9125    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    8.0708  -14.9125    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    7.5750  -14.4750    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    7.5875  -13.8750    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    7.0708  -13.5667    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    6.5458  -13.8583    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    6.5375  -14.4583    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    7.0542  -14.7667    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n    7.8875  -15.4833    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n    8.3750  -15.8333    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n    8.8583  -15.4833    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n   11.0958  -14.8708    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   11.6958  -14.8708    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   12.2750  -14.4375    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   12.2667  -13.8375    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   12.7792  -13.5292    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   13.3042  -13.8208    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   13.3125  -14.4208    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   12.7958  -14.7292    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n   10.9083  -15.4417    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n   11.3917  -15.7958    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n   11.8792  -15.4458    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n  1  2  2  0  0  0  0\n  2  3  1  0  0  0  0\n  3  4  2  0  0  0  0\n  4  5  1  0  0  0  0\n  5  6  2  0  0  0  0\n  6  1  1  0  0  0  0\n  2  7  1  0  0  0  0\n  7  8  2  0  0  0  0\n  8  9  1  0  0  0  0\n  9 10  2  0  0  0  0\n 10 11  1  0  0  0  0\n 11 12  2  0  0  0  0\n 12 13  1  0  0  0  0\n 13 14  2  0  0  0  0\n 14  9  1  0  0  0  0\n  8 15  1  0  0  0  0\n 15 16  2  0  0  0  0\n 16 17  1  0  0  0  0\n 17  7  1  0  0  0  0\n 18 19  2  0  0  0  0\n 19 20  1  0  0  0  0\n 20 21  2  0  0  0  0\n 21 22  1  0  0  0  0\n 22 23  2  0  0  0  0\n 23 24  1  0  0  0  0\n 24 25  2  0  0  0  0\n 25 20  1  0  0  0  0\n 18 26  1  0  0  0  0\n 26 27  2  0  0  0  0\n 27 28  1  0  0  0  0\n 28 19  1  0  0  0  0\n  4 18  1  0  0  0  0\nM  END" }
      sample_desc { "This is not an actual description but we needed to test this field" }
      sample_melting_point { -Float::INFINITY...Float::INFINITY }
      sample_boiling_point { -Float::INFINITY...Float::INFINITY }
      target_amount_value { 0.0 }
      target_amount_unit { "g" }
      rs_type { nil }
      add_attribute(:yield) { nil }
      iupac_name { "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine" }
      cano_smiles { "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1" }
      sum_formular { "C20H14N8" }
      inchikey { "MUAMZYSBUQADBN-UHFFFAOYSA-N" }
      inchistring { "InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)" }
      molecular_weight { "366.37876000000006>" }
    end

    trait :with_realistic_attributes_and_two_authors do
      taggable_data {
        {"doi" => "10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1",
         "sid" => "384636332",
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
         "queued_at" => "2019-06-27T15:58:15.129+02:00",
         "author_ids" => [130],
         "chem_first" => "2019-06-27T21:01:09.781+02:00",
         "doi_reg_at" => "2019-06-27T21:01:09.781+02:00",
         "affiliations" => {"1537" => "Institute of Toxicology and Genetics, Karlsruhe Institute of Technology, Germany"},
         "analysis_ids" => [499476],
         "published_at" => "2019-06-27T21:01:12.455+02:00",
         "published_by" => 130,
         "pubchem_reg_at" => "2019-06-27T21:01:12.414+02:00",
         "sample_version" => 1,
         "affiliation_ids" => [[1537]],
         "original_analysis_ids" => [495836]}
      }
      element_type { "Sample" }
      element_id { 43961 }
      metadata_xml { # HINT: It is that broken in database.
        <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <resource xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://datacite.org/schema/kernel-4" xsi:schemaLocation="http://datacite.org/schema/kernel-4 http://schema.datacite.org/meta/kernel-4.1/metadata.xsd">
            <identifier identifierType="DOI">10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N.1</identifier>
            <creators>
              <creator>
                <creatorName nameType="Personal">Huang, Yu-Chieh</creatorName>
                <givenName>Yu-Chieh</givenName>
                <familyName>Huang</familyName>
                  <affiliation>Institute of Toxicology and Genetics, Karlsruhe Institute of Technology, Germany</affiliation>
              </creator>
            </creators>
            <titles>
              <title xml:lang="en-US">C20H14N8</title>
              <title titleType="AlternativeTitle">InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)</title>
            </titles>
            <publisher>chemotion.net</publisher>
            <publicationYear>2019</publicationYear>
            <dates>
            <date dateType="Created">2019-06-27 13:58:50 UTC</date>
            </dates>
            <subjects>
              <subject>Chemistry</subject>
            </subjects>
            <language>en</language>
            <resourceType resourceTypeGeneral="Dataset">Molecule</resourceType>
            <version>1</version>
            <descriptions>
              <description xml:lang="en-US" descriptionType="Abstract">
                This dataset contains experimental data from a sample (InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)).<br />
                The datasets from the following experiments are available:<br />
                
                      IR<br />
                
              </description>
            </descriptions>
            <relatedIdentifiers>
              <relatedIdentifier relatedIdentifierType="DOI" relationType="HasPart">10.14272/MUAMZYSBUQADBN-UHFFFAOYSA-N/IR</relatedIdentifier>
            </relatedIdentifiers>
          </resource>
        XML
      }
      published_at { "Thu, 27 Jun 2019 19:01:12.455291000 UTC +00:00" }
      doi_suffix { "MUAMZYSBUQADBN-UHFFFAOYSA-N.1" }
      extended_metadata { nil }
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
      sample_svg_file { "bf6a432662c34510bf77006c2db915f9be86a1a626255ddb07fdec5849d49a093ad8a2db7fd29a522f8f0b49d05740c8409a085283c5d47d3821daad374edf8e.svg" }
      molfile { "\n  -ISIS-  03031715412D\n\n 28 32  0  0  0  0  0  0  0  0999 V2000\n    9.3167  -13.8083    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    9.3333  -14.4083    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    9.8625  -14.6917    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   10.3750  -14.3792    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   10.3542  -13.7792    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    9.8250  -13.4958    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    8.6708  -14.9125    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    8.0708  -14.9125    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    7.5750  -14.4750    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    7.5875  -13.8750    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    7.0708  -13.5667    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    6.5458  -13.8583    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    6.5375  -14.4583    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n    7.0542  -14.7667    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n    7.8875  -15.4833    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n    8.3750  -15.8333    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n    8.8583  -15.4833    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n   11.0958  -14.8708    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   11.6958  -14.8708    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   12.2750  -14.4375    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   12.2667  -13.8375    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   12.7792  -13.5292    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   13.3042  -13.8208    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   13.3125  -14.4208    0.0000 C   0  0  0  0  0  0  0  0  0  0  0  0\n   12.7958  -14.7292    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n   10.9083  -15.4417    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n   11.3917  -15.7958    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n   11.8792  -15.4458    0.0000 N   0  0  0  0  0  0  0  0  0  0  0  0\n  1  2  2  0  0  0  0\n  2  3  1  0  0  0  0\n  3  4  2  0  0  0  0\n  4  5  1  0  0  0  0\n  5  6  2  0  0  0  0\n  6  1  1  0  0  0  0\n  2  7  1  0  0  0  0\n  7  8  2  0  0  0  0\n  8  9  1  0  0  0  0\n  9 10  2  0  0  0  0\n 10 11  1  0  0  0  0\n 11 12  2  0  0  0  0\n 12 13  1  0  0  0  0\n 13 14  2  0  0  0  0\n 14  9  1  0  0  0  0\n  8 15  1  0  0  0  0\n 15 16  2  0  0  0  0\n 16 17  1  0  0  0  0\n 17  7  1  0  0  0  0\n 18 19  2  0  0  0  0\n 19 20  1  0  0  0  0\n 20 21  2  0  0  0  0\n 21 22  1  0  0  0  0\n 22 23  2  0  0  0  0\n 23 24  1  0  0  0  0\n 24 25  2  0  0  0  0\n 25 20  1  0  0  0  0\n 18 26  1  0  0  0  0\n 26 27  2  0  0  0  0\n 27 28  1  0  0  0  0\n 28 19  1  0  0  0  0\n  4 18  1  0  0  0  0\nM  END" }
      sample_desc { "This is not an actual description but we needed to test this field" }
      sample_melting_point { -Float::INFINITY...Float::INFINITY }
      sample_boiling_point { -Float::INFINITY...Float::INFINITY }
      target_amount_value { 0.0 }
      target_amount_unit { "g" }
      rs_type { nil }
      add_attribute(:yield) { nil }
      iupac_name { "2-[5-[3-(5-pyridin-2-yl-2H-triazol-4-yl)phenyl]-2H-triazol-4-yl]pyridine" }
      cano_smiles { "c1ccc(nc1)c1[nH]nnc1c1cccc(c1)c1[nH]nnc1c1ccccn1" }
      sum_formular { "C20H14N8" }
      inchikey { "MUAMZYSBUQADBN-UHFFFAOYSA-N" }
      inchistring { "InChI=1S/C20H14N8/c1-3-10-21-15(8-1)19-17(23-27-25-19)13-6-5-7-14(12-13)18-20(26-28-24-18)16-9-2-4-11-22-16/h1-12H,(H,23,25,27)(H,24,26,28)" }
      molecular_weight { "366.37876000000006>" }
    end
  end
end
