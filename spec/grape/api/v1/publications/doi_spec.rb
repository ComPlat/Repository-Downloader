describe "API::V1::Publication::Doi" do
  let(:args) { {city: "Town", street: "Doi Street 1", zip: "12345"} }
  let(:address_mapper) { AddressMapper.new(**args) }

  describe "GET /api/v1/publications/doi" do
    before { get "/api/v1/publications/doi/" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq MappersPresenter.new(AddressMapper, [args, args]).to_json }
    it { expect(response.content_type).to eq("application/json") }
  end
end
