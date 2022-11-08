describe ArrayXmlMapperBuilder do
  let(:test_mapper_args) { {string: "string_value"} }
  let(:test_mapper) {
    stub_const("TestMapper",
      Class.new(ShaleCustom::Mapper) { attribute :string, Shale::Type::String })
  }
  let(:tests_mapper_class) { Object.const_get(:TestsMapper) }

  describe ".new" do
    subject { described_class.new(test_mapper, [test_mapper_args, test_mapper_args]) }

    it { is_expected.to be_a described_class }
  end

  describe "#build" do
    subject(:build) { array_xml_mapper_builder.build }

    let(:array_xml_mapper_builder) { described_class.new(test_mapper, [test_mapper_args, test_mapper_args]) }

    it { is_expected.to be_a tests_mapper_class }

    context "when build was already called on same instance" do
      before { array_xml_mapper_builder.build }

      it "can be build more than once on same instance because class is not defined again" do
        expect(build).to be_a tests_mapper_class
      end
    end

    context "when build was already called on another instance" do
      before { described_class.new(test_mapper, [test_mapper_args, test_mapper_args]).build }

      it "can be build more than once on same instance because class is not defined again" do
        expect(build).to be_a tests_mapper_class
      end
    end
  end
end
