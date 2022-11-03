describe ShaleCustom::Mapper do
  it { expect(described_class.new).to be_a described_class }
  it { expect(described_class.xml_mapping).to be_a ShaleCustom::Xml }
  it { expect(described_class.csv_mapping).to be_a Shale::Mapping::Dict }
  it { expect(described_class.csv_mapping.instance_variable_get(:@render_nil_default)).to be true }
  it { expect(described_class.json_mapping).to be_a Shale::Mapping::Dict }
  it { expect(described_class.json_mapping.instance_variable_get(:@render_nil_default)).to be true }
  it { expect(described_class.inherited(AddressMapper)).to eq "address" }
end
