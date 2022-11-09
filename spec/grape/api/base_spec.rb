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
      let(:expected_routes) do
        {"messages" => [
          be_a(Grape::Router::Route).and(have_attributes(path: "/:version/messages/:id(.:format)", version: "v1")),
          be_a(Grape::Router::Route).and(have_attributes(path: "/:version/messages(.:format)", version: "v1"))
        ]}
      end

      it { expect(combined_routes).to include expected_routes }
    end
  end

  describe "inheritable_setting.namespace_stackable[:formatters]" do
    subject(:formatters) { described_class.inheritable_setting.namespace_stackable[:formatters] }

    let(:test_mapper) do
      stub_const("TestMapper",
        Class.new(ShaleCustom::Mapper) { attribute :string, Shale::Type::String })
        .new(string: "string_value")
    end

    it { is_expected.to match([{xml: be_a(Proc)}, {json: be_a(Proc)}]) }
    it { expect(formatters.length).to eq 2 }

    it do
      allow(test_mapper).to receive(:to_xml)

      formatters.first[:xml].call(test_mapper, nil)

      expect(test_mapper).to have_received(:to_xml).with(no_args).once
    end

    it do
      allow(test_mapper).to receive(:to_json)

      formatters.second[:json].call(test_mapper, nil)

      expect(test_mapper).to have_received(:to_json).with(no_args).once
    end
  end

  describe "response.headers" do
    let(:test_api) { Class.new(described_class) }

    before { test_api.get "test" }

    describe "GET /api/v1/test" do
      before { get "/api/v1/test" }

      it { expect(response.headers.length).to eq 7 }
      it { expect(response.headers["Content-Type"]).to eq "application/json" }
      it { expect(response.headers["Access-Control-Allow-Origin"]).to eq "*" }
      it { expect(response.headers["Access-Control-Request-Method"]).to eq "*" }
      it { expect(response.headers["Cache-Control"]).to eq "no-cache" }
      it { expect(response.headers["X-Request-Id"]).to be_a String }
      it { expect(response.headers["X-Runtime"]).to be_a String }
      it { expect(response.headers["Content-Length"]).to be_a String }
    end

    describe "GET /api/v1/test.xml" do
      before { get "/api/v1/test.xml" }

      it { expect(response.headers["Content-Type"]).to eq "application/xml" }
    end
  end
end
