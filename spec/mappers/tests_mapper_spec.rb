describe "TestsMapper" do
  # HINT: Testing meta class generated by ArrayXmlMapperBuilder.
  let(:test_mapper_args) { {string: "string_value"} }
  let(:test_mapper_class) do
    stub_const("TestMapper",
      Class.new(ShaleCustom::Mapper) { attribute :string, Shale::Type::String })
  end
  let(:tests_mapper_class_via_const_get) { Object.const_get(:TestsMapper) }

  let(:tests_mapper_class_from_array_xml_mapper_builder) do
    ArrayXmlMapperBuilder.new(test_mapper_class, []).send(:klass_with_attribute)
  end

  describe ".new" do
    subject { tests_mapper_class_from_array_xml_mapper_builder.new }

    it { is_expected.to be_a tests_mapper_class_via_const_get }
  end

  describe "#to_xml" do
    subject(:to_xml) { tests_mapper_from_array_xml_mapper_builder.to_xml }

    context "with no_args" do
      let(:tests_mapper_from_array_xml_mapper_builder) { tests_mapper_class_from_array_xml_mapper_builder.new }

      it { is_expected.to eq "<tests/>" }
    end

    context "with empty array" do
      let(:tests_mapper_from_array_xml_mapper_builder) { tests_mapper_class_from_array_xml_mapper_builder.new(test: []) }

      it { is_expected.to eq "<tests/>" }
    end

    context "with one arg" do
      let(:tests_mapper_from_array_xml_mapper_builder) do
        tests_mapper_class_from_array_xml_mapper_builder.new(test: [test_mapper_class.new(**test_mapper_args)])
      end

      it { is_expected.to eq "<tests><test><string>string_value</string></test></tests>" }
    end

    context "with multiple args" do
      let(:tests_mapper_from_array_xml_mapper_builder) do
        tests_mapper_class_from_array_xml_mapper_builder
          .new(test: [test_mapper_class.new(**test_mapper_args), test_mapper_class.new(**test_mapper_args)])
      end

      it { is_expected.to eq "<tests><test><string>string_value</string></test><test><string>string_value</string></test></tests>" }
    end
  end

  describe "#to_json" do
    subject(:to_json) { tests_mapper_from_array_xml_mapper_builder.to_json }

    context "with no_args" do
      let(:tests_mapper_from_array_xml_mapper_builder) { tests_mapper_class_from_array_xml_mapper_builder.new }

      it { is_expected.to eq "{\"test\":[]}" }
    end

    context "with empty array" do
      let(:tests_mapper_from_array_xml_mapper_builder) { tests_mapper_class_from_array_xml_mapper_builder.new(test: []) }

      it { is_expected.to eq "{\"test\":[]}" }
    end

    context "with one arg" do
      let(:tests_mapper_from_array_xml_mapper_builder) do
        tests_mapper_class_from_array_xml_mapper_builder.new(test: [test_mapper_class.new(**test_mapper_args)])
      end

      it { is_expected.to eq "{\"test\":[{\"string\":\"string_value\"}]}" }
    end

    context "with multiple arg" do
      let(:tests_mapper_from_array_xml_mapper_builder) do
        tests_mapper_class_from_array_xml_mapper_builder
          .new(test: [test_mapper_class.new(**test_mapper_args), test_mapper_class.new(**test_mapper_args)])
      end

      it { is_expected.to eq "{\"test\":[{\"string\":\"string_value\"},{\"string\":\"string_value\"}]}" }
    end
  end
end
