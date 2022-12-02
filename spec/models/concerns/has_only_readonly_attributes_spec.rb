describe HasOnlyReadonlyAttributes do
  let(:test_publication_model_class) do
    Class.new {
      include ActiveRecord::ReadonlyAttributes

      def self.attribute_names = ["id"]

      include HasOnlyReadonlyAttributes
    }
  end

  it { expect(test_publication_model_class.readonly_attributes.to_a).to eq test_publication_model_class.attribute_names }
  it { expect(test_publication_model_class.readonly_attributes.to_a).to eq ["id"] }
end
