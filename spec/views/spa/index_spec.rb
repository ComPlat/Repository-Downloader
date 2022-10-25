describe "spa/index" do
  before { render }

  it { expect(controller.request.path_parameters).to eq action: "index", controller: "spa" }
  it { expect(rendered).to include '<div id="spa"></div>' }
end
