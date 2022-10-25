describe SpaController do
  describe "GET index" do
    subject { response }

    before { get :index }

    it { is_expected.to have_http_status(:ok) }
    it { is_expected.to have_rendered("spa/index", "layouts/application") }
  end
end
