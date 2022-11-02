describe PersonMapper do
  let(:first_name) { "John" }
  let(:last_name) { "Doe" }
  let(:age) { 25 }
  let(:married) { true }
  let(:hobbies) { ["Guitar", "Music", "Reading"] }

  let(:city) { "city" }
  let(:street) { "street" }
  let(:zip) { "zip" }
  let(:address) { AddressMapper.new city:, street:, zip: }

  context "when called without any arguments" do
    let(:person_mapper) { described_class.new }

    it { expect(person_mapper).to be_a described_class }
    it { expect(person_mapper.first_name).to be_nil }
    it { expect(person_mapper.last_name).to be_nil }
    it { expect(person_mapper.age).to be_nil }
    it { expect(person_mapper.married).to be false }
    it { expect(person_mapper.hobbies).to match_array([]) }
    # TODO:
    it { expect(person_mapper.to_json).to eq "{\"married\":false,\"hobbies\":[]}" }
    it { expect(person_mapper.to_xml).to eq "<person_mapper><married>false</married></person_mapper>" }
    it { expect(person_mapper.to_csv).to eq ",,,false,[],\n" }
  end

  context "when called with all arguments" do
    let(:person_mapper) { described_class.new first_name:, last_name:, age:, married:, hobbies:, address: }

    it { expect(person_mapper).to be_a described_class }
    it { expect(person_mapper.first_name).to eq first_name }
    it { expect(person_mapper.last_name).to eq last_name }
    it { expect(person_mapper.age).to eq age }
    it { expect(person_mapper.married).to eq married }
    it { expect(person_mapper.hobbies).to eq hobbies }

    it { expect(person_mapper.address.city).to eq city }
    it { expect(person_mapper.address.street).to eq street }
    it { expect(person_mapper.address.zip).to eq zip }

    it do
      expect(person_mapper.to_json)
        .to eq "{\"first_name\":\"John\"," \
                "\"last_name\":\"Doe\"," \
                "\"age\":25," \
                "\"married\":true," \
                "\"hobbies\":[\"Guitar\",\"Music\",\"Reading\"]," \
                "\"address\":{\"city\":\"city\",\"street\":\"street\",\"zip\":\"zip\"}}"
    end

    it do
      expect(person_mapper.to_xml).to eq "<person_mapper><first_name>John</first_name><last_name>Doe</last_name><age>25</age><married>true</ma...</hobbies><address><city>city</city><street>street</street><zip>zip</zip></address></person_mapper>"
    end

    it { expect(person_mapper.to_csv).to eq "city,street,zip\n" }
  end

  context "when called some arguments" do
    let(:person_mapper) { described_class.new city:, street: nil, zip: }

    it { expect(person_mapper).to be_a described_class }
    it { expect(person_mapper.city).to eq city }
    it { expect(person_mapper.street).to be_nil }
    it { expect(person_mapper.zip).to eq zip }
    it { expect(person_mapper.to_json).to eq "{\"city\":\"city\",\"street\":null,\"zip\":\"zip\"}" }
    it { expect(person_mapper.to_xml).to eq "<address><city>city</city><street/><zip>zip</zip></address>" }
    it { expect(person_mapper.to_csv).to eq "city,,zip\n" }
  end
end
