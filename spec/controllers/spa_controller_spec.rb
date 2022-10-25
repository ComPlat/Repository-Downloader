describe SpaController do
  describe "GET index" do
    render_views
    subject { response }

    before { get :index }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to have_rendered("spa/index", "layouts/application") }
    it { expect(response.body).to include "<div id=\"spa\"></div>" }
  end
end
