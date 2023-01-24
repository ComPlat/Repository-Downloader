describe API::Base do
  describe ".new" do
    subject { described_class.new }

    it { is_expected.to be_a Grape::API::Instance }
  end

  describe ".default_format" do
    subject { described_class.default_format }

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
      it { expect(combined_routes).to include({"publications" => all(be_a(Grape::Router::Route))}) }
      it { expect(combined_routes["publications"].size).to eq 2 }
      it { expect(combined_routes).to include({"publications" => include(have_attributes(path: "/:version/publications/search(.:format)", version: "v1"))}) }
      it { expect(combined_routes).to include({"publications" => include(have_attributes(path: "/:version/publications(.:format)", version: "v1"))}) }
    end
  end

  describe "inheritable_setting.namespace_stackable[:formatters]" do
    subject(:formatters) { described_class.inheritable_setting.namespace_stackable[:formatters] }

    let(:test_presenter) do
      stub_const("TestPresenter",
        Class.new do
          def to_json = nil

          def to_xml = nil

          def to_csv = nil

          def to_zip = nil
        end)
        .new
    end

    it { is_expected.to match [{json: be_a(Proc)}, {csv: be_a(Proc)}, {zip: be_a(Proc)}, {xml: be_a(Proc)}] }
    it { expect(formatters.length).to eq 4 }

    it do
      allow(test_presenter).to receive(:to_json)

      formatters.first[:json].call(test_presenter, nil)

      expect(test_presenter).to have_received(:to_json).with(no_args).once
    end

    it do
      allow(test_presenter).to receive(:to_csv)

      formatters.second[:csv].call(test_presenter, nil)

      expect(test_presenter).to have_received(:to_csv).with(no_args).once
    end

    it do
      allow(test_presenter).to receive(:to_zip)

      formatters.third[:zip].call(test_presenter, nil)

      expect(test_presenter).to have_received(:to_zip).with(no_args).once
    end

    it do
      allow(test_presenter).to receive(:to_xml)

      formatters.fourth[:xml].call(test_presenter, nil)

      expect(test_presenter).to have_received(:to_xml).with(no_args).once
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
      # HINT: This is because Rspec simulates browser behaviour which sets accept headers to accept xml but not json
      it { expect(response.headers["Content-Type"]).to eq "application/xml" }
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
      {info: {title: "Chemotion Repository Downloader", version: "v1"},
       swagger: "2.0",
       host: ENV["HOST_URI"], # HINT: Default value for host URI
       basePath: "/api",
       tags: [{name: "publications", description: "Operations about publications"}],
       paths: {"/v1/publications": {get:
                    {description: "Get publications via ChemotionID(s) or DOI(s)",
                     operationId: "getV1Publications",
                     parameters: [
                       {collectionFormat: "csv",
                        description: "List of DOIs, separated by comma, either this or chemotion_ids needs to be given",
                        in: "query",
                        items: {type: "string"},
                        name: "dois",
                        required: false,
                        type: "array"},
                       {collectionFormat: "csv",
                        description: "List of Chemotion IDs, separated by comma, either this or dois needs to be given",
                        in: "query",
                        items: {format: "int32", type: "integer"},
                        name: "chemotion_ids",
                        required: false,
                        type: "array"}
                     ],
                     produces: ["application/json", "application/xml", "text/csv", "application/zip"],
                     responses: {"200": {description: "Get publications via ChemotionID(s) or DOI(s)"}},
                     tags: ["publications"]}},
               "/v1/publications/search": {get:
                                             {description: "Search publications via authors and/or contributor and/or description",
                                              operationId: "getV1PublicationsSearch",
                                              parameters: [
                                                {collectionFormat: "pipes",
                                                 description: "List of Authors, separated by |, only finds exact matches by name",
                                                 in: "query",
                                                 items: {default: "Author Name", type: "string"},
                                                 name: "authors_value",
                                                 required: false,
                                                 type: "array"},
                                                {collectionFormat: "pipes",
                                                 description: "Must be either EQUAL or LIKE",
                                                 in: "query",
                                                 items: {default: "EQUAL", type: "string"},
                                                 name: "authors_search_operator",
                                                 required: true,
                                                 type: "array"},
                                                {description: "Single Contributor, only finds matches by name",
                                                 in: "query",
                                                 name: "contributor_value",
                                                 required: false,
                                                 type: "string"},
                                                {enum: ["EQUAL", "LIKE"],
                                                 in: "query",
                                                 name: "contributor_search_operator",
                                                 required: true,
                                                 type: "string"},
                                                {description: "Searches description for a single search term",
                                                 in: "query",
                                                 name: "description_value",
                                                 required: false,
                                                 type: "string"},
                                                {enum: ["EQUAL", "LIKE"],
                                                 in: "query",
                                                 name: "description_search_operator",
                                                 required: true,
                                                 type: "string"}
                                              ],
                                              produces: ["application/json", "application/xml", "text/csv"],
                                              responses: {"200": {description: "Search publications via authors and/or contributor and/or description"}},
                                              tags: ["publications"]}}},
       produces: %w[application/json text/csv application/zip application/xml]}
    end

    before { get "/api/swagger_doc.json" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(JSON.parse(response.body).deep_symbolize_keys).to eq expected_body }
  end
end
