describe "SWAGGER" do
  let(:expected_body) do
    {info: {title: "API title", version: "0.0.1"},
     swagger: "2.0",
     produces: %w[application/json application/xml],
     host: ENV["HOST_URI"], # HINT: Default value for host URI
     basePath: "/api",
     tags: [{name: "publications", description: "Operations about publications"}],
     paths: {"/v1/publications/chemotion_id": {get: {description: "Return list of publications",
                                                     produces: ["application/json"],
                                                     responses: {"200": {description: "Return list of publications"}},
                                                     tags: ["publications"],
                                                     operationId: "getV1PublicationsChemotionId"}},
             "/v1/publications/chemotion_id/{id}": {get: {description: "Get one publication via ChemotionID",
                                                          produces: ["application/json"],
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
