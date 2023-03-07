RSpec.describe "SPA" do
  it do
    visit "/"
    expect(page).to have_selector "h2", text: "Chemotion Repository Downloader"
  end
end
