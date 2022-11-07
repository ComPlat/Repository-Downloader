describe "API::Messages" do
  let(:address_mapper) { AddressMapper.new(city: "Town", street: "Elm Street 1", zip: "12345") }

  it do
    get "/api/not_existing_path"
    expect(response).to have_http_status(:not_found)
  end

  describe "GET /api/messages" do
    before { get "/api/messages" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq AddressMapper.to_json([address_mapper, address_mapper]) }
    it { expect(response.content_type).to eq("application/json") }

    # it "gets json header" do
    #   get api_path, headers: {"HTTP_ACCEPT" => "application/json"}
    #   expect(response.header["Content-Type"]).to eq "application/json"
    # end
    #
    # it "gets xml header" do
    #   get api_path, headers: {"HTTP_ACCEPT" => "application/xml"}
    #   expect(response.header["Content-Type"]).to eq "application/xml"
    # end
    #
    # it "gets json header even http accept is not valid" do
    #   get api_path, headers: {"HTTP_ACCEPT" => "application/not_valid_header"}
    #   expect(response.header["Content-Type"]).to eq "application/json"
    # end
  end

  describe "GET /api/messages/:id.json" do
    #   let(:valid_id) { 0 }
    #   let(:invalid_id) { 10000000 }

    before { get "/api/messages/1.json" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq address_mapper.to_json }
    it { expect(response.content_type).to eq("application/json") }
    #
    #   it "to get one message unsuccessful" do
    #     get "#{api_path}/#{invalid_id}"
    #     expect(response).to have_http_status(:not_found)
    #   end
    #
    #   describe "GET /api/messages/:path" do
    #     let(:not_valid_path) { "not_valid_path" }
    #
    #     it "sends a bad request" do
    #       get "#{api_path}/#{not_valid_path}"
    #       expect(response).to have_http_status(:bad_request)
    #     end
    #   end
  end

  describe "GET /api/messages/:id.xml" do
    before { get "/api/messages/1.xml" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq address_mapper.to_xml }
    it { expect(response.content_type).to eq("application/xml") }
  end
end
