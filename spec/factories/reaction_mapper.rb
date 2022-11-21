FactoryBot.define do
  factory :reaction_mapper, class: "RootMappers::ReactionMapper" do
    trait :with_all_args do
      add_attribute(:context) { "https://schema.org/" } # HINT: Otherwise Rubocop is confused.
      id { "https://www.rhea-db.org/reaction?id=51724" }
      type { "BioChemicalReaction" }
      name { "H2O + P(1),P(6)-bis(5'-adenosyl) hexaphosphate = adenosine 5'-tetraphosphate + ADP + 2 H(+)" }
      identifier { "RHEA:51724" }
      status { "schema:Approved" }
      description { "Chemically balanced" }
      temperature { "10 °C" }
      reaction_type { "RXNO:0000300 | thiol-ene reaction" }
      duration { "18 Hour(s)" }
      purification { "HPLC" }
      reagents_list { build :reagents_list_mapper, :with_all_args }
    end
  end
end
