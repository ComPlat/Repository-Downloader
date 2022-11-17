describe ShaleCustom::Mapper do
  let(:sub_class) do
    Class.new(described_class) do
      def self.name = "Module::NestedTestMapper"

      attribute :string, Shale::Type::String
      attribute :integer, Shale::Type::Integer
    end
  end
  let(:sub_object) { sub_class.new(string: "string_value", integer: 0) }

  it { expect(described_class.new).to be_a described_class }
  it { expect(described_class.xml_mapping).to be_a ShaleCustom::Xml }
  it { expect(described_class.csv_mapping).to be_a Shale::Mapping::Dict }
  it { expect(described_class.csv_mapping.instance_variable_get(:@render_nil_default)).to be true }
  it { expect(described_class.json_mapping).to be_a Shale::Mapping::Dict }
  it { expect(described_class.json_mapping.instance_variable_get(:@render_nil_default)).to be true }
  it { expect(sub_object.class.instance_variable_get(:@xml_mapping).instance_variable_get(:@root)).to eq "nestedTest" }

  describe ".from_hash" do
    it { expect { sub_class.from_hash(nil) }.to raise_error ArgumentError, "hash needs to be a Hash, but it is a NilClass" }
    it { expect(sub_class.from_hash({})).to be_a sub_class }
    it { expect(sub_class.from_hash({})).to have_attributes(string: nil, integer: nil) }
    it { expect(sub_class.from_hash({string: "", integer: 0})).to have_attributes(string: "", integer: 0) }
    it { expect(sub_class.from_hash({"string" => "", "integer" => 0})).to have_attributes(string: "", integer: 0) }
  end

  describe "#to_csv" do
    it { expect(sub_object.to_csv).to eq "string,integer\n#{sub_object.string},#{sub_object.integer}\n" }
    it { expect(sub_object.to_csv(headers: false)).to eq "#{sub_object.string},#{sub_object.integer}\n" }
    it { expect(sub_object.to_csv(col_sep: "|")).to eq "string|integer\n#{sub_object.string}|#{sub_object.integer}\n" }
  end
end
