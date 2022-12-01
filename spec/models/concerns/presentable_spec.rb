describe Presentable do
  let(:test_publication_model_class) { stub_const("TestPublicationModel", Class.new { include Presentable }) }
  let(:test_publication_mapper_class) do
    stub_const("RootMappers::TestPublicationModelMapper", Class.new {
      def self.from_hash(hash) = new
    })
  end
  let(:test_publication_mapper_adapter_class) do
    stub_const("RootAdapters::TestPublicationModelToTestPublicationModelMapperAdapter", Class.new {
      def initialize(model) = @model = model

      def to_h = {}
    })
  end

  let(:test_publication_object) { test_publication_model_class.new }

  describe "#present_to_api" do
    subject(:present_to_api) { test_publication_object.present_to_api }

    before {
      test_publication_mapper_class
      test_publication_mapper_adapter_class
    }

    it { is_expected.to be_a test_publication_mapper_class }
  end
end
