describe "API::V1" do
  describe "GET /api/v1/:path" do
    xcontext "when path does not exist" do
      before { get "/api/v1/not_existing_path" }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to eq "{\"error\":\"Not found\"}" }
    end
  end
end
