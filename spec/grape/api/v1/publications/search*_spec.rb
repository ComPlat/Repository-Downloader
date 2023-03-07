describe API::V1::Publications::Search do
  let!(:analysis1) { create(:analysis, :with_realistic_attributes) }
  let!(:reaction1) { create(:reaction, :with_realistic_attributes_and_two_authors) }

  describe "GET api/v1/publications/search?...&format=json" do
    context "with one author only" do
      let(:author) { analysis1.taggable_data["creators"].first["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape author}&authors_search_operator=EQUAL&format=json"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.parsed_body).to eq [analysis1.id] }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two authors" do
      let(:author1) { reaction1.taggable_data["creators"].first["name"] }
      let(:author2) { reaction1.taggable_data["creators"].second["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape author1}#{CGI.escape "\t"}#{CGI.escape author2}&authors_search_operator=EQUAL#{CGI.escape "\t"}EQUAL&contributor_search_operator=EQUAL&description_search_operator=EQUAL&format=json"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.parsed_body).to eq [reaction1.id] }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two authors but only one author search operator" do
      let(:author1) { reaction1.taggable_data["creators"].first["name"] }
      let(:author2) { reaction1.taggable_data["creators"].second["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape author1}#{CGI.escape "\t"}#{CGI.escape author2}&authors_search_operator=EQUAL&contributor_search_operator=EQUAL&description_search_operator=EQUAL&format=json"
      end

      it { expect(response).to have_http_status :bad_request }
      it { expect(response.parsed_body).to eq({"message" => "authors_value and authors_search_operator must have the same length"}) }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two authors and the contributor" do
      let(:authors) { [reaction1.taggable_data["creators"].first["name"], reaction1.taggable_data["creators"].second["name"]] }
      let(:contributor) { reaction1.taggable_data["contributors"]["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape authors.first}#{CGI.escape "\t"}#{CGI.escape authors.second}&authors_search_operator=EQUAL#{CGI.escape "\t"}EQUAL&contributor_value=#{CGI.escape contributor}&contributor_search_operator=EQUAL&description_search_operator=EQUAL&format=json"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.parsed_body).to eq [reaction1.id] }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with the contributor and the description" do
      let(:contributor) { reaction1.taggable_data["contributors"]["name"] }
      let(:description) { reaction1.reaction_description }

      before do
        get "/api/v1/publications/search?contributor_value=#{CGI.escape contributor}&contributor_search_operator=EQUAL&description_value=#{CGI.escape description}&description_search_operator=EQUAL&format=json"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.parsed_body).to eq [reaction1.id] }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with yield_over and yield_under" do
      let(:yield_over) { reaction1.yield - 1 }
      let(:yield_under) { reaction1.yield + 1 }

      before do
        get "/api/v1/publications/search?yield_over=#{yield_over}&yield_under=#{yield_under}&format=json"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.parsed_body).to eq [reaction1.id] }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with published_before and published_after" do
      let(:published_before) { reaction1.published_at + 1.day }
      let(:published_after) { reaction1.published_at - 1.day }

      before do
        get "/api/v1/publications/search?published_before=#{published_before}&published_after=#{published_after}&format=json"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.parsed_body).to eq [reaction1.id] }
      it { expect(response.content_type).to eq "application/json" }
    end

    context "with two authors, contributor, description, yield_* and published_*" do
      let(:authors) { [reaction1.taggable_data["creators"].first["name"], reaction1.taggable_data["creators"].second["name"]] }
      let(:contributor) { reaction1.taggable_data["contributors"]["name"] }
      let(:description) { reaction1.reaction_description }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape authors.first}#{CGI.escape "\t"}#{CGI.escape authors.second}&authors_search_operator=EQUAL#{CGI.escape "\t"}EQUAL&contributor_value=#{CGI.escape contributor}&contributor_search_operator=EQUAL&description_value=#{CGI.escape description}&description_search_operator=EQUAL&published_after=#{reaction1.published_at - 1.day}&published_before=#{reaction1.published_at + 1.day}&yield_over=#{reaction1.yield - 1}&yield_under=#{reaction1.yield + 1}&format=json"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.parsed_body).to eq [reaction1.id] }
      it { expect(response.content_type).to eq "application/json" }
    end
  end

  describe "GET api/v1/publications/search?...&format=xml" do
    context "with one author only" do
      let(:author) { analysis1.taggable_data["creators"].first["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape author}&authors_search_operator=EQUAL&format=xml"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "application/xml" }

      it do
        expect(response.body).to eq(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<integers type=\"array\">\n  <integer type=\"integer\">#{analysis1.id}</integer>\n</integers>\n"
        )
      end
    end

    context "with two authors" do
      let(:author1) { reaction1.taggable_data["creators"].first["name"] }
      let(:author2) { reaction1.taggable_data["creators"].second["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape author1}#{CGI.escape "\t"}#{CGI.escape author2}&authors_search_operator=EQUAL#{CGI.escape "\t"}EQUAL&contributor_search_operator=EQUAL&description_search_operator=EQUAL&format=xml"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "application/xml" }

      it do
        expect(response.body).to eq(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<integers type=\"array\">\n  <integer type=\"integer\">#{reaction1.id}</integer>\n</integers>\n"
        )
      end
    end

    context "with two authors but only one author search operator" do
      let(:author1) { reaction1.taggable_data["creators"].first["name"] }
      let(:author2) { reaction1.taggable_data["creators"].second["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape author1}#{CGI.escape "\t"}#{CGI.escape author2}&authors_search_operator=EQUAL&contributor_search_operator=EQUAL&description_search_operator=EQUAL&format=xml"
      end

      it { expect(response).to have_http_status :bad_request }
      it { expect(response.content_type).to eq "application/xml" }

      it do
        expect(response.body).to eq(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<hash>\n  <message>authors_value and authors_search_operator must have the same length</message>\n</hash>\n"
        )
      end
    end

    context "with two authors and the contributor" do
      let(:authors) { [reaction1.taggable_data["creators"].first["name"], reaction1.taggable_data["creators"].second["name"]] }
      let(:contributor) { reaction1.taggable_data["contributors"]["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape authors.first}#{CGI.escape "\t"}#{CGI.escape authors.second}&authors_search_operator=EQUAL#{CGI.escape "\t"}EQUAL&contributor_value=#{CGI.escape contributor}&contributor_search_operator=EQUAL&description_search_operator=EQUAL&format=xml"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "application/xml" }

      it do
        expect(response.body).to eq(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<integers type=\"array\">\n  <integer type=\"integer\">#{reaction1.id}</integer>\n</integers>\n"
        )
      end
    end

    context "with the contributor and the description" do
      let(:contributor) { reaction1.taggable_data["contributors"]["name"] }
      let(:description) { reaction1.reaction_description }

      before do
        get "/api/v1/publications/search?contributor_value=#{CGI.escape contributor}&contributor_search_operator=EQUAL&description_value=#{CGI.escape description}&description_search_operator=EQUAL&format=xml"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "application/xml" }

      it do
        expect(response.body).to eq(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<integers type=\"array\">\n  <integer type=\"integer\">#{reaction1.id}</integer>\n</integers>\n"
        )
      end
    end

    context "with yield_over and yield_under" do
      let(:yield_over) { reaction1.yield - 1 }
      let(:yield_under) { reaction1.yield + 1 }

      before do
        get "/api/v1/publications/search?yield_over=#{yield_over}&yield_under=#{yield_under}&format=xml"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "application/xml" }

      it do
        expect(response.body).to eq(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<integers type=\"array\">\n  <integer type=\"integer\">#{reaction1.id}</integer>\n</integers>\n"
        )
      end
    end

    context "with published_before and published_after" do
      let(:published_before) { reaction1.published_at + 1.day }
      let(:published_after) { reaction1.published_at - 1.day }

      before do
        get "/api/v1/publications/search?published_before=#{published_before}&published_after=#{published_after}&format=xml"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "application/xml" }

      it do
        expect(response.body).to eq(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<integers type=\"array\">\n  <integer type=\"integer\">#{reaction1.id}</integer>\n</integers>\n"
        )
      end
    end

    context "with two authors, contributor, description, yield_* and published_*" do
      let(:authors) { [reaction1.taggable_data["creators"].first["name"], reaction1.taggable_data["creators"].second["name"]] }
      let(:contributor) { reaction1.taggable_data["contributors"]["name"] }
      let(:description) { reaction1.reaction_description }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape authors.first}#{CGI.escape "\t"}#{CGI.escape authors.second}&authors_search_operator=EQUAL#{CGI.escape "\t"}EQUAL&contributor_value=#{CGI.escape contributor}&contributor_search_operator=EQUAL&description_value=#{CGI.escape description}&description_search_operator=EQUAL&published_after=#{reaction1.published_at - 1.day}&published_before=#{reaction1.published_at + 1.day}&yield_over=#{reaction1.yield - 1}&yield_under=#{reaction1.yield + 1}&format=xml"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "application/xml" }

      it do
        expect(response.body).to eq(
          "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<integers type=\"array\">\n  <integer type=\"integer\">#{reaction1.id}</integer>\n</integers>\n"
        )
      end
    end
  end

  describe "GET api/v1/publications/search?...&format=csv" do
    context "with one author only" do
      let(:author) { analysis1.taggable_data["creators"].first["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape author}&authors_search_operator=EQUAL&format=csv"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "text/csv" }
      it { expect(response.body).to eq("#{analysis1.id}\n") }
    end

    context "with two authors" do
      let(:author1) { reaction1.taggable_data["creators"].first["name"] }
      let(:author2) { reaction1.taggable_data["creators"].second["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape author1}#{CGI.escape "\t"}#{CGI.escape author2}&authors_search_operator=EQUAL#{CGI.escape "\t"}EQUAL&contributor_search_operator=EQUAL&description_search_operator=EQUAL&format=csv"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "text/csv" }
      it { expect(response.body).to eq("#{reaction1.id}\n") }
    end

    context "with two authors but only one author search operator" do
      let(:author1) { reaction1.taggable_data["creators"].first["name"] }
      let(:author2) { reaction1.taggable_data["creators"].second["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape author1}#{CGI.escape "\t"}#{CGI.escape author2}&authors_search_operator=EQUAL&contributor_search_operator=EQUAL&description_search_operator=EQUAL&format=csv"
      end

      it { expect(response).to have_http_status :bad_request }
      it { expect(response.content_type).to eq "text/csv" }
      it { expect(response.body).to eq("authors_value and authors_search_operator must have the same length\n") }
    end

    context "with two authors and the contributor" do
      let(:authors) { [reaction1.taggable_data["creators"].first["name"], reaction1.taggable_data["creators"].second["name"]] }
      let(:contributor) { reaction1.taggable_data["contributors"]["name"] }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape authors.first}#{CGI.escape "\t"}#{CGI.escape authors.second}&authors_search_operator=EQUAL#{CGI.escape "\t"}EQUAL&contributor_value=#{CGI.escape contributor}&contributor_search_operator=EQUAL&description_search_operator=EQUAL&format=csv"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "text/csv" }
      it { expect(response.body).to eq("#{reaction1.id}\n") }
    end

    context "with the contributor and the description" do
      let(:contributor) { reaction1.taggable_data["contributors"]["name"] }
      let(:description) { reaction1.reaction_description }

      before do
        get "/api/v1/publications/search?contributor_value=#{CGI.escape contributor}&contributor_search_operator=EQUAL&description_value=#{CGI.escape description}&description_search_operator=EQUAL&format=csv"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "text/csv" }
      it { expect(response.body).to eq("#{reaction1.id}\n") }
    end

    context "with yield_over and yield_under" do
      let(:yield_over) { reaction1.yield - 1 }
      let(:yield_under) { reaction1.yield + 1 }

      before do
        get "/api/v1/publications/search?yield_over=#{yield_over}&yield_under=#{yield_under}&format=csv"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "text/csv" }
      it { expect(response.body).to eq("#{reaction1.id}\n") }
    end

    context "with published_before and published_after" do
      let(:published_before) { reaction1.published_at + 1.day }
      let(:published_after) { reaction1.published_at - 1.day }

      before do
        get "/api/v1/publications/search?published_before=#{published_before}&published_after=#{published_after}&format=csv"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "text/csv" }
      it { expect(response.body).to eq("#{reaction1.id}\n") }
    end

    context "with two authors, contributor, description, yield_* and published_*" do
      let(:authors) { [reaction1.taggable_data["creators"].first["name"], reaction1.taggable_data["creators"].second["name"]] }
      let(:contributor) { reaction1.taggable_data["contributors"]["name"] }
      let(:description) { reaction1.reaction_description }

      before do
        get "/api/v1/publications/search?authors_value=#{CGI.escape authors.first}#{CGI.escape "\t"}#{CGI.escape authors.second}&authors_search_operator=EQUAL#{CGI.escape "\t"}EQUAL&contributor_value=#{CGI.escape contributor}&contributor_search_operator=EQUAL&description_value=#{CGI.escape description}&description_search_operator=EQUAL&published_after=#{reaction1.published_at - 1.day}&published_before=#{reaction1.published_at + 1.day}&yield_over=#{reaction1.yield - 1}&yield_under=#{reaction1.yield + 1}&format=csv"
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response.content_type).to eq "text/csv" }
      it { expect(response.body).to eq("#{reaction1.id}\n") }
    end
  end
end
