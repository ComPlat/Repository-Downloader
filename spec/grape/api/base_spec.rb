describe API::Base do
  describe ".new" do
    subject { described_class.new }

    it { is_expected.to be_a Grape::API::Instance }
  end

  describe ".format" do
    subject { described_class.format }

    it { is_expected.to eq :json }
  end

  describe ".content_types" do
    subject { described_class.content_types }

    it { is_expected.to eq({json: "application/json", xml: "application/xml"}) }
  end

  describe ".combined_routes" do
    subject(:combined_routes) { described_class.combined_routes }

    it { expect(combined_routes.length).to eq 2 }
    it { expect(combined_routes).to include({"swagger_doc" => []}) }

    describe "messages routes" do
      let(:expected_routes) {
        {
          "messages" => [
            be_a(Grape::Router::Route).and(have_attributes(path: "/:version/messages/:id(.:format)", version: "v1")),
            be_a(Grape::Router::Route).and(have_attributes(path: "/:version/messages(.:format)", version: "v1"))
          ]
        }
      }

      it { expect(combined_routes).to include expected_routes }
    end
  end

  describe "inheritable_setting.namespace_stackable[:formatters]" do
    subject { described_class.inheritable_setting.namespace_stackable[:formatters] }

    it { is_expected.to match([{xml: be_a(Proc)}, {json: be_a(Proc)}]) }

    # TODO: Check if proc do execute .to_json and to .to_xml in each case
    #  subject.first[:xml].call(SOME_SPY_OBJECT_THAT_CAN_BE_CALLED_THAT_WAY, nil)
  end

  # TODO: Test Headers
end
