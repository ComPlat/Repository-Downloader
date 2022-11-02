describe "API::Messages" do
  context "when condition" do
    it "succeeds" do
      get "/api/messages"
      expect(response).to have_http_status(:ok)
    end
  end
end
