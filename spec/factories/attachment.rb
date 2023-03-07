FactoryBot.define do
  factory :attachment do
    trait :with_required_dependencies do
      analysis { create(:analysis) }
    end

    trait :with_realistic_attributes do
      name { "R53A_EI-MS" }
      ds_desc { "" }
      filesize { "46034" }
      ds_id { 681160 }
      # noinspection RubyResolve
      extended_metadata { {"report" => "true", "instrument" => " Bruker"} }
      att_id { 237933 }
      filename { "JK20-proton.peak.png" }
      identifier { "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a" }
      storage { "local" }
      content_type { "image/png" }
      bucket { "24" }
      akey { "6954c6ca-adef-4ab1-b00b-31dbf9c53c8a" }
    end
  end
end
