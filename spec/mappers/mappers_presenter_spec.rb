describe MappersPresenter do
  let(:test_mapper_args) { {string: "string_value"} }
  let(:test_mapper_class) {
    stub_const("TestMapper",
      Class.new(ShaleCustom::Mapper) { attribute :string, Shale::Type::String })
  }

  describe ".new" do
    it { expect(described_class.new(test_mapper_class, [test_mapper_args])).to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) { mappers_presenter.to_json }

    context "with empty array" do
      let(:mappers_presenter) { described_class.new(test_mapper_class, []) }

      it { is_expected.to eq "[]" }
    end

    context "with one arg" do
      let(:mappers_presenter) { described_class.new(test_mapper_class, [test_mapper_args]) }

      it { is_expected.to eq "[{\"string\":\"string_value\"}]" }
      it { is_expected.to eq test_mapper_class.to_json([test_mapper_class.new(**test_mapper_args)]) }
    end

    context "with multiple args" do
      let(:mappers_presenter) { described_class.new(test_mapper_class, [test_mapper_args, test_mapper_args]) }

      it { is_expected.to eq "[{\"string\":\"string_value\"},{\"string\":\"string_value\"}]" }
    end
  end

  describe "#to_xml" do
    subject(:to_xml) { mappers_presenter.to_xml }

    context "with empty array" do
      let(:mappers_presenter) { described_class.new(test_mapper_class, []) }

      it { is_expected.to eq "<tests/>" }
    end

    context "with one arg" do
      let(:mappers_presenter) { described_class.new(test_mapper_class, [test_mapper_args]) }

      it { is_expected.to eq "<tests><test><string>string_value</string></test></tests>" }
    end

    context "with multiple args" do
      let(:mappers_presenter) { described_class.new(test_mapper_class, [test_mapper_args, test_mapper_args]) }

      it { is_expected.to eq "<tests><test><string>string_value</string></test><test><string>string_value</string></test></tests>" }
    end
  end
end
