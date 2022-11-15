FactoryBot.define do
  factory :attachment do
    trait :with_realistic_attributes do
      ana_id { 680937 }
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