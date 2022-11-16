describe API::V1::Publications::ChemotionId do
  let(:analysis) { create :analysis, :with_realistic_attributes }

  describe "GET /api/v1/publications/chemotion_id/:chemotion_id" do
    context "with existing chemotion_id" do
      before { get "/api/v1/publications/chemotion_id/#{analysis.id}" }

      let(:expected_json) { PublicationPresenter.present_by_chemotion_id(analysis.id).to_json }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq expected_json }
      it { expect(response.content_type).to eq("application/json") }
    end

    context "with NOT existing chemotion_id" do
      let(:not_existing_chemotion_id) { 0 }
      let(:expected_json) { PublicationPresenter.present_by_chemotion_id(analysis.id).to_json }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :not_found }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Couldn't find Publication with 'id'=#{not_existing_chemotion_id}"}) }
      it { expect(response.content_type).to eq("application/json") }
    end
  end
end
