describe Presentable do
  let(:test_publication_model_class) { stub_const("TestPublicationModel", Class.new { include Presentable }) }
  let(:test_publication_presenter_class) do
    stub_const("TestPublicationModelPresenter", Class.new {
      def initialize(model) = nil
    })
  end

  let(:test_publication_model_object) { test_publication_model_class.new }

  describe "#present_to_api" do
    subject(:present_to_api) { test_publication_model_object.present_to_api }

    before { test_publication_presenter_class }

    it { is_expected.to be_a test_publication_presenter_class }
  end
end
