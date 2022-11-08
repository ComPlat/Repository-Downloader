describe "API::V1" do
  describe "GET /api/v1/:path" do
    context "when path does exist" do
      let(:args) { {city: "Town", street: "Elm Street 1", zip: "12345"} }

      before { get "/api/v1/messages" }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to eq MappersPresenter.new(AddressMapper, [args, args]).to_json }
    end

    context "when path does not exist" do
      before { get "/api/v1/not_existing_path" }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.body).to eq "{\"error\":\"Not found\"}" }
    end
  end
end
