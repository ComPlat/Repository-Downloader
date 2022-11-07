describe ShaleCustom::Mapper do
  let(:sub_object) do
    Class.new(described_class) do
      def self.name = "TestMapper"

      attribute :string, Shale::Type::String
      attribute :integer, Shale::Type::Integer
    end.new(string: "string_value", integer: 0)
  end

  it { expect(described_class.new).to be_a described_class }
  it { expect(described_class.xml_mapping).to be_a ShaleCustom::Xml }
  it { expect(described_class.csv_mapping).to be_a Shale::Mapping::Dict }
  it { expect(described_class.csv_mapping.instance_variable_get(:@render_nil_default)).to be true }
  it { expect(described_class.json_mapping).to be_a Shale::Mapping::Dict }
  it { expect(described_class.json_mapping.instance_variable_get(:@render_nil_default)).to be true }
  it { expect(sub_object.class.instance_variable_get(:@xml_mapping).instance_variable_get(:@root)).to eq "test" }

  describe ".to_csv" do
    it { expect(sub_object.to_csv).to eq "string,integer\n#{sub_object.string},#{sub_object.integer}\n" }
    it { expect(sub_object.to_csv(headers: false)).to eq "#{sub_object.string},#{sub_object.integer}\n" }
    it { expect(sub_object.to_csv(col_sep: "|")).to eq "string|integer\n#{sub_object.string}|#{sub_object.integer}\n" }
  end
end
