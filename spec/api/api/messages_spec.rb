describe "API::Messages" do
  let(:address_mapper) { AddressMapper.new(city: "Town", street: "Elm Street 1", zip: "12345") }

  describe "GET /api/not_existing_path" do
    before { get "/api/not_existing_path" }

    it { expect(response).to have_http_status(:not_found) }
    it { expect(response.body).to eq "{\"error\":\"Not found\"}" }
  end

  describe "GET /api/messages" do
    let(:args) { {city: "Town", street: "Elm Street 1", zip: "12345"} }

    before { get "/api/messages" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq MappersPresenter.new(AddressMapper, [args, args]).to_json }
    it { expect(response.content_type).to eq("application/json") }
  end

  describe "GET /api/messages/:id.json" do
    before { get "/api/messages/1.json" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq address_mapper.to_json }
    it { expect(response.content_type).to eq("application/json") }
  end

  describe "GET /api/messages/:id.xml" do
    context "when get request is successful and message with :id exists" do
      before { get "/api/messages/1.xml" }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to eq address_mapper.to_xml }
      it { expect(response.content_type).to eq("application/xml") }
    end

    context "when get request is not successful and message with :id is missing" do
      before { get "/api/messages/100000000000.xml" }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to eq "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<error>\n  <message>Invalid message: 100000000000</message>\n</error>\n" }
      it { expect(response.content_type).to eq("application/xml") }
    end
  end

  describe "GET /api/messages/:path" do
    before { get "/api/messages/not_valid_path" }

    it { expect(response).to have_http_status(:bad_request) }
    it { expect(response.body).to eq "{\"error\":\"id is invalid\"}" }
  end
end
