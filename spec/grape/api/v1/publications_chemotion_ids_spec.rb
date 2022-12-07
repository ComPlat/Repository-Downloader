describe API::V1::Publications, ".chemotion_ids" do
  let(:analysis1) { create :analysis, :with_realistic_attributes }
  let(:analysis2) { create :analysis, :with_realistic_attributes }

  describe "GET /api/v1/publications?chemotion_ids={analysis1.id}&format=json" do
    context "with existing chemotion_id" do
      before { get "/api/v1/publications?chemotion_ids=#{analysis1.id}&format=json" }

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq PublicationsByChemotionIdPresenter.new(analysis1.id).to_json.to_a.join }
      it { expect(response.content_type).to eq "application/json" }
    end

    xcontext "with NOT existing chemotion_id=0" do
      let(:not_existing_chemotion_id) { 0 }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    xcontext "with NOT existing chemotion_id=-1" do
      let(:not_existing_chemotion_id) { -1 }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    xcontext "with illegal chemotion_id format containing alphabetical characters" do
      let(:not_existing_chemotion_id) { "ABC" }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end
  end

  xdescribe "GET /api/v1/publications/chemotion_id/:chemotion_id1, :chemotion_id2" do
    context "with two existing chemotion_id" do
      before { get "/api/v1/publications/chemotion_id/#{analysis1.id},#{analysis2.id}" }

      let(:expected_json) do
        [PublicationPresenter.present_by_chemotion_id(analysis1.id),
          PublicationPresenter.present_by_chemotion_id(analysis2.id)].to_json
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.body).to eq expected_json }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with one not existing chemotion_id=0" do
      let(:not_existing_chemotion_id) { 0 }

      before { get "/api/v1/publications/chemotion_id/#{analysis1.id},#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{analysis1.id},#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two not existing chemotion_id=0" do
      let(:not_existing_chemotion_id) { 0 }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id},#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{not_existing_chemotion_id},#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with one not existing chemotion_id=-1" do
      let(:not_existing_chemotion_id) { -1 }

      before { get "/api/v1/publications/chemotion_id/#{analysis1.id},#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{analysis1.id},#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two not existing chemotion_id=-1" do
      let(:not_existing_chemotion_id) { -1 }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id},#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{not_existing_chemotion_id},#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with one illegal chemotion_id format containing alphabetical characters" do
      let(:not_existing_chemotion_id) { "ABC" }

      before { get "/api/v1/publications/chemotion_id/#{analysis1.id},#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{analysis1.id},#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two illegal chemotion_id format containing alphabetical characters" do
      let(:not_existing_chemotion_id) { "ABC" }

      before { get "/api/v1/publications/chemotion_id/#{not_existing_chemotion_id},#{not_existing_chemotion_id}" }

      it { expect(response).to have_http_status :unprocessable_entity }
      it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{not_existing_chemotion_id},#{not_existing_chemotion_id} not valid"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    # TODO: That is not yet working because Rspec / CGI / ... formats whitespaces different than most browsers & postman
    # context "with one empty chemotion_id" do
    #  let(:empty_chemotion_id) { CGI.escape("  ") }
    #
    # before { get "/api/v1/publications/chemotion_id/#{analysis1.id},#{empty_chemotion_id},#{analysis2.id}" }
    #
    # it { expect(response).to have_http_status :unprocessable_entity }
    # it { expect(JSON.parse(response.body)).to eq({"error" => "Unprocessable Entity, 'id'=#{analysis1.id},#{empty_chemotion_id},#{analysis2.id}, not valid"}) }
    # it { expect(response.content_type).to eq "application/json" }
    # end
  end
end
