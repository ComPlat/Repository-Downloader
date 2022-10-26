describe SpaController do
  describe "#new" do
    subject { described_class.new }

    it { is_expected.to be_a described_class }
    it { is_expected.to be_a ApplicationController }
  end

  describe "GET index" do
    subject { response }

    before { get :index }

    it { is_expected.to have_http_status :ok }
    it { is_expected.to have_rendered "spa/index", "layouts/application" }
  end
end
