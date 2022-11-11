describe "API::V1::Search" do
  let(:args) { {city: "Town", street: "Search Street 1", zip: "12345"} }
  let(:address_mapper) { AddressMapper.new(**args) }

  describe "GET /api/v1/search/1" do
    before { post "/api/v1/search/result?id=1&address=address }" }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.body).to eq address_mapper.to_json }
  end
end
