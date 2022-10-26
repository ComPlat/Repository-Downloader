require "rails_helper"
require "./app/presenters/person_presenter"

describe PersonPresenter do
  let(:first_name) { "John" }
  let(:last_name) { "Doe" }
  # let(:city) { "San Francisco" }
  # let(:address) { Address.new(city: "San Francisco") }
  let(:person) { Person.new(first_name: first_name, last_name: last_name, address: Address.new(city: "San Francisco")) }
  let(:presenter) { PersonPresenter.new(person) }

  describe "#full_name" do
    let(:expected_full_name) { "#{first_name} #{last_name}" }

    it "returns full name as one string" do
      expect(presenter.full_name).to eq expected_full_name
    end
  end

  describe "#to_json" do
    let(:expected_json) do
      <<~JSON.chomp
        {\"first_name\":\"John\",\"last_name\":\"Doe\",\"married\":false,\"hobbies\":[],\"address\":{\"city\":\"San Francisco\"}}
      JSON
    end

    it "returns json representation" do
      expect(presenter.to_json).to eq expected_json
    end
  end

  describe "#to_xml" do
    let(:expected_xml) do
      <<~XML.chomp
        <person><first_name>John</first_name><last_name>Doe</last_name><married>false</married><address><city>San Francisco</city></address></person>
      XML
    end

    it "returns xml representation" do
      expect(presenter.to_xml).to eq expected_xml
    end
  end

  describe "#to_csv" do
    let(:expected_csv) do
      <<~CSV
        John,Doe,,false,[],"{""city""=>""San Francisco"", ""street""=>nil, ""zip""=>nil}"
      CSV
    end

    it "returns csv representation" do
      expect(presenter.to_csv).to eq expected_csv
    end
  end
end
