describe "API::Messages" do
  describe "GET /api/messages" do
    it do
      get "/api/messages"
      expect(response).to have_http_status(:ok)
    end
  end
end
