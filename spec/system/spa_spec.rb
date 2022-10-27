RSpec.describe "SPA" do
  it do
    visit "/"
    expect(page).to have_selector "h1", text: "Hello World!"
  end
end
