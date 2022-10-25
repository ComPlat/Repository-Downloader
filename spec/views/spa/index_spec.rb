describe "spa/index" do
  before { render }

  it { expect(rendered).to include '<div id="spa"></div>' }
end
