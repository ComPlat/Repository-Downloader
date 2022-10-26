describe SpaController do
  describe "GET /" do
    subject { response }

    before { get "/" }

    it { is_expected.to have_http_status :ok }
    it { is_expected.to have_rendered "spa/index", "layouts/application" }
    it { expect(response.body).to include '<div id="spa"></div>' }
  end
end
