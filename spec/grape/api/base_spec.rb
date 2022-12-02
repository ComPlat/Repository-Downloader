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

    it { is_expected.to eq({csv: "text/csv", json: "application/json", xml: "application/xml", zip: "application/zip"}) }
  end

  describe ".combined_routes" do
    subject(:combined_routes) { described_class.combined_routes }

    it { expect(combined_routes.length).to eq 2 }
    it { expect(combined_routes).to include({"swagger_doc" => []}) }

    describe "publications routes" do
      let(:expected_routes) do
        # HINT: combined_routes["publications"].map { |route|  [route.path, route.version] }
        {"publications" => [
          be_a(Grape::Router::Route).and(have_attributes(path: "/:version/publications/chemotion_id/:id(.:format)", version: "v1"))
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

    it { is_expected.to match [{xml: be_a(Proc)}, {json: be_a(Proc)}, {csv: be_a(Proc)}, zip: be_a(Proc)] }
    it { expect(formatters.length).to eq 4 }

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

    it do
      allow(test_mapper).to receive(:to_csv)

      formatters.third[:csv].call(test_mapper, nil)

      expect(test_mapper).to have_received(:to_csv).with(no_args).once
    end
  end

  describe "inheritable_setting.namespace_stackable[:rescue_options]" do
    subject(:rescue_options) { described_class.inheritable_setting.namespace_stackable[:rescue_options] }

    it { is_expected.to eq [{}] }
  end

  describe "inheritable_setting.namespace_reverse_stackable[:rescue_handlers]" do
    subject(:rescue_options) { described_class.inheritable_setting.namespace_reverse_stackable[:rescue_handlers] }

    it { is_expected.to match [{ActiveRecord::RecordNotFound => be_a(Proc)}] }
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

  describe "/api/swagger_doc.json" do
    let(:expected_body) do
      {info: {title: "API title", version: "0.0.1"},
       swagger: "2.0",
       produces: %w[application/json application/xml text/csv application/zip],
       host: ENV["HOST_URI"], # HINT: Default value for host URI
       basePath: "/api",
       tags: [{name: "publications", description: "Operations about publications"}],
       paths: {"/v1/publications/chemotion_id/{id}": {get: {description: "Get one publication via ChemotionID",
                                                            produces: %w[application/json application/xml text/csv],
                                                            parameters: [{in: "path",
                                                                          name: "id",
                                                                          description: "ChemotionID",
                                                                          type: "integer",
                                                                          format: "int32",
                                                                          required: true}],
                                                            responses: {"200": {description: "Get one publication via ChemotionID"}},
                                                            tags: ["publications"],
                                                            operationId: "getV1PublicationsChemotionIdId"}}}}
    end

    before { get "/api/swagger_doc.json" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(JSON.parse(response.body).deep_symbolize_keys).to eq expected_body }
  end
end
