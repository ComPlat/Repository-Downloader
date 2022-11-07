describe "API::Messages" do
  let(:api_path) { "/api/messages" }

  it do
    get "/api/not_existing_path"
    expect(response).to have_http_status(:not_found)
  end

  describe "GET /api/messages" do
    it "gets all messages successfully" do
      get api_path
      expect(response).to have_http_status(:ok)
    end

    it "gets json header" do
      get api_path, headers: {"HTTP_ACCEPT" => "application/json"}
      expect(response.header["Content-Type"]).to eq "application/json"
    end

    it "gets xml header" do
      get api_path, headers: {"HTTP_ACCEPT" => "application/xml"}
      expect(response.header["Content-Type"]).to eq "application/xml"
    end

    it "gets json header even http accept is not valid" do
      get api_path, headers: {"HTTP_ACCEPT" => "application/not_valid_header"}
      expect(response.header["Content-Type"]).to eq "application/json"
    end
  end

  describe "GET /api/messages/:id" do
    let(:valid_id) { 0 }
    let(:invalid_id) { 10000000 }

    it "gets one message successful" do
      get "#{api_path}/#{valid_id}"
      expect(response).to have_http_status(:ok)
    end

    it "to get one message unsuccessful" do
      get "#{api_path}/#{invalid_id}"
      expect(response).to have_http_status(:not_found)
    end

    describe "GET /api/messages/:path" do
      let(:not_valid_path) { "not_valid_path" }

      it "sends a bad request" do
        get "#{api_path}/#{not_valid_path}"
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
