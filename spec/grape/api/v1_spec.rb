describe "API::V1" do
  describe "GET /api/v1/:path" do
    context "when path does not exist with json format" do
      before { get "/api/v1/not_existing_path?format=json" }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to eq "{\"error\":\"Not found\"}" }
    end

    context "when path does not exist with xml format" do
      before { get "/api/v1/not_existing_path?format=xml" }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to eq "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<error>\n  <message>Not found</message>\n</error>\n" }
    end
  end
end
