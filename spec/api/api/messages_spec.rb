describe "API::Messages" do
  describe "GET /api/messages" do
    it do
      get "/api/messages"
      expect(response).to have_http_status(:ok)
    end

    it do
      get "/api/not_existing_path"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /api/messages/:id" do
    it "returns 200" do
      get "/api/messages/#id=0"
      expect(response).to have_http_status(:ok)
    end
  end
end
