describe API::V1::Publications::ChemotionId do
  let(:analysis) { create :analysis, :with_realistic_attributes }

  describe "GET /api/v1/publications/chemotion_id/:chemotion_id" do
    context "with existing chemotion_id" do
      before { get "/api/v1/publications/chemotion_id/#{analysis.id}" }

      let(:expected_json) { PublicationPresenter.present_by_chemotion_id(analysis.id).to_json.to_a.join }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq expected_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with NOT existing chemotion_id=0" do
      let(:not_existing_chemotion_id) { 0 }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with NOT existing chemotion_id=-1" do
      let(:not_existing_chemotion_id) { -1 }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end
  end
end
