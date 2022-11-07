describe ShaleCustom::Mapper do
  it { expect(described_class.new).to be_a described_class }
  it { expect(described_class.xml_mapping).to be_a ShaleCustom::Xml }
  it { expect(described_class.csv_mapping).to be_a Shale::Mapping::Dict }
  it { expect(described_class.csv_mapping.instance_variable_get(:@render_nil_default)).to be true }
  it { expect(described_class.json_mapping).to be_a Shale::Mapping::Dict }
  it { expect(described_class.json_mapping.instance_variable_get(:@render_nil_default)).to be true }
  it { expect(AddressMapper.new.class.instance_variable_get(:@xml_mapping).instance_variable_get(:@root)).to eq "address" }

  describe ".to_csv" do
    let(:address_mapper) { build :address_mapper }

    it { expect(address_mapper).to be_a described_class }
    it { expect(address_mapper.class.instance_variable_get(:@csv_mapping)).to be_a Shale::Mapping::Dict }

    context "with default parameters headers are enabled" do
      let(:expected_csv) do
        <<~CSV
          city,street,zip
          ,,
        CSV
      end

      it { expect(address_mapper.to_csv).to eq_without_whitespace expected_csv }
    end

    context "when parameters are overridden" do
      let(:expected_csv) do
        <<~CSV
          ,,
        CSV
      end

      it { expect(address_mapper.to_csv(headers: false)).to eq_without_whitespace expected_csv }
    end

    context "when additional parameters are given" do
      let(:expected_csv) do
        <<~CSV
          city|street|zip
          ||
        CSV
      end

      it { expect(address_mapper.to_csv(col_sep: "|")).to eq_without_whitespace expected_csv }
    end
  end
end
