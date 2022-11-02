describe AddressMapper do
  context "when called without any arguments" do
    let(:address_mapper) { build :address_mapper }

    it { expect(address_mapper).to be_a described_class }
    it { expect(address_mapper.city).to be_nil }
    it { expect(address_mapper.street).to be_nil }
    it { expect(address_mapper.zip).to be_nil }
    it { expect(address_mapper.to_json).to eq "{\"city\":null,\"street\":null,\"zip\":null}" }
    it { expect(address_mapper.to_xml).to eq "<address><city/><street/><zip/></address>" }
    it { expect(address_mapper.to_csv).to eq ",,\n" }
  end

  context "when called with all arguments" do
    let(:args) { attributes_for :address_mapper, :with_all_args }
    let(:address_mapper) { described_class.new(**args) }

    it { expect(address_mapper).to be_a described_class }
    it { expect(address_mapper.city).to eq args[:city] }
    it { expect(address_mapper.street).to eq args[:street] }
    it { expect(address_mapper.zip).to eq args[:zip] }
    it { expect(address_mapper.to_json).to eq "{\"city\":\"#{args[:city]}\",\"street\":\"#{args[:street]}\",\"zip\":\"#{args[:zip]}\"}" }
    it { expect(address_mapper.to_xml).to eq "<address><city>#{args[:city]}</city><street>#{args[:street]}</street><zip>#{args[:zip]}</zip></address>" }
    it { expect(address_mapper.to_csv).to eq "#{args[:city]},#{args[:street]},#{args[:zip]}\n" }
  end

  context "when called some arguments" do
    let(:args) { attributes_for :address_mapper, :with_all_args, street: nil }
    let(:address_mapper) { described_class.new(**args) }

    it { expect(address_mapper).to be_a described_class }
    it { expect(address_mapper.city).to eq args[:city] }
    it { expect(address_mapper.street).to eq args[:street] }
    it { expect(address_mapper.zip).to eq args[:zip] }
    it { expect(address_mapper.to_json).to eq "{\"city\":\"#{args[:city]}\",\"street\":null,\"zip\":\"#{args[:zip]}\"}" }
    it { expect(address_mapper.to_xml).to eq "<address><city>#{args[:city]}</city><street/><zip>#{args[:zip]}</zip></address>" }
    it { expect(address_mapper.to_csv).to eq "#{args[:city]},,#{args[:zip]}\n" }
  end
end
