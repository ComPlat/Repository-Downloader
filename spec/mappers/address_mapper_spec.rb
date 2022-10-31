describe AddressMapper do
  let(:city) { "city" }
  let(:street) { "street" }
  let(:zip) { "zip" }

  context "when called without any arguments" do
    let(:address_mapper) { described_class.new }

    it { expect(address_mapper).to be_a described_class }
    it { expect(address_mapper.city).to be_nil }
    it { expect(address_mapper.street).to be_nil }
    it { expect(address_mapper.zip).to be_nil }
    it { expect(address_mapper.to_json).to eq "{\"city\":null,\"street\":null,\"zip\":null}" }
    it { expect(address_mapper.to_xml).to eq "<address><city/><street/><zip/></address>" }
    it { expect(address_mapper.to_csv).to eq ",,\n" }
  end

  context "when called with all arguments" do
    let(:address_mapper) { described_class.new city:, street:, zip: }

    it { expect(address_mapper).to be_a described_class }
    it { expect(address_mapper.city).to eq city }
    it { expect(address_mapper.street).to eq street }
    it { expect(address_mapper.zip).to eq zip }
    it { expect(address_mapper.to_json).to eq "{\"city\":\"city\",\"street\":\"street\",\"zip\":\"zip\"}" }
    it { expect(address_mapper.to_xml).to eq "<address><city>city</city><street>street</street><zip>zip</zip></address>" }
    it { expect(address_mapper.to_csv).to eq "city,street,zip\n" }
  end

  context "when called some arguments" do
    let(:address_mapper) { described_class.new city:, street: nil, zip: }

    it { expect(address_mapper).to be_a described_class }
    it { expect(address_mapper.city).to eq city }
    it { expect(address_mapper.street).to be_nil }
    it { expect(address_mapper.zip).to eq zip }
    it { expect(address_mapper.to_json).to eq "{\"city\":\"city\",\"street\":null,\"zip\":\"zip\"}" }
    it { expect(address_mapper.to_xml).to eq "<address><city>city</city><street/><zip>zip</zip></address>" }
    it { expect(address_mapper.to_csv).to eq "city,,zip\n" }
  end
end
