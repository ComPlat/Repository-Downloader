describe "SWAGGER" do
  let(:expected_body) do
    {info: {title: "API title", version: "0.0.1"},
     swagger: "2.0",
     produces: %w[application/json application/xml],
     host: ENV["HOST_URI"], # HINT: Default value for host URI
     basePath: "/api",
     tags: [{name: "messages", description: "Operations about messages"}],
     paths: {"/v1/messages": {get: {description: "Return list of messages",
                                    produces: ["application/json"],
                                    responses: {"200": {description: "Return list of messages"}},
                                    tags: ["messages"],
                                    operationId: "getV1Messages"}},
             "/v1/messages/{id}": {get: {description: "Return a message",
                                         produces: ["application/json"],
                                         parameters: [{in: "path",
                                                       name: "id",
                                                       description: "Message ID",
                                                       type: "integer",
                                                       format: "int32",
                                                       required: true}],
                                         responses: {"200": {description: "Return a message"}},
                                         tags: ["messages"],
                                         operationId: "getV1MessagesId"}}}}
  end

  before { get "/api/swagger_doc.json" }

  it { expect(response).to have_http_status(:ok) }
  it { expect(JSON.parse(response.body).deep_symbolize_keys).to eq expected_body }
end
