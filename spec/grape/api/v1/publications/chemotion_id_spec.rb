describe "API::V1::Publication::ChemotionId" do
  let(:args) { {city: "Town", street: "Chemotion Street 1", zip: "12345"} }
  let(:address_mapper) { AddressMapper.new(**args) }

  describe "GET /api/v1/publications/chemotion_id" do
    before { get "/api/v1/publications/chemotion_id/" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq MappersPresenter.new(AddressMapper, [args, args]).to_json }
    it { expect(response.content_type).to eq("application/json") }
  end
end
