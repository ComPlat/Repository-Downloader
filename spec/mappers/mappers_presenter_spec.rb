describe MappersPresenter do
  let(:mapper_class) do
    Class.new(ShaleCustom::Mapper) {
      def self.name = "TestMapper"

      attribute :string, Shale::Type::String
    }
  end
  let(:mapper_args) { {string: "string_value"} }

  describe ".new" do
    it { expect(described_class.new(mapper_class, [mapper_args])).to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) { mappers_presenter.to_json }

    let(:mappers_presenter) { described_class.new(mapper_class, [mapper_args]) }

    it { is_expected.to eq "[{\"string\":\"string_value\"}]" }
    it { is_expected.to eq mapper_class.to_json([mapper_class.new(**mapper_args)]) }
  end

  describe "#to_xml" do
    subject(:to_xml) { mappers_presenter.to_xml }

    let(:args) { attributes_for :address_mapper, :with_all_args, street: nil }
    # TODO: Does not work with mapper_class. What is it missing?
    let(:mappers_presenter) { described_class.new(AddressMapper, [args, args]) }

    it { is_expected.to eq "<addresses><address><city>city</city><street/><zip>zip</zip></address><address><city>city</city><street/><zip>zip</zip></address></addresses>" }
    # it { is_expected.to eq mapper_class.to_xml([mapper_class.new(**mapper_args)]) }
  end
end
