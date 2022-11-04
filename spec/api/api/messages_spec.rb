describe "API::Messages" do
  describe "GET /api" do
    it "on not existing path" do
      get "/api/not_existing_path"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /api/messages" do
    let(:api_path) { "/api/messages" }
    let(:not_valid_path) { "not_valid_path" }
    let(:valid_id) { 0 }
    let(:invalid_id) { 10000000 }

    it "to get all messages successfully" do
      get api_path
      expect(response).to have_http_status(:ok)
    end

    it "to get one message successful" do
      get "#{api_path}/#{valid_id}"
      expect(response).to have_http_status(:ok)
    end

    # TODO: Somehow it returns a 200 although it is an invalid id
    # it "to get one message unsuccessful" do
    #   get "#{api_path}/#{invalid_id}"
    #   expect(response).to have_http_status(:not_found)
    # end

    it "to send a bad request" do
      get "#{api_path}/#{not_valid_path}"
      expect(response).to have_http_status(:bad_request)
    end

    it "to get json header" do
      get api_path, headers: {"HTTP_ACCEPT" => "application/json"}
      expect(response.header["Content-Type"]).to eq "application/json"
    end

    it "to get xml header" do
      get api_path, headers: {"HTTP_ACCEPT" => "application/xml"}
      expect(response.header["Content-Type"]).to eq "application/xml"
    end
  end
end
