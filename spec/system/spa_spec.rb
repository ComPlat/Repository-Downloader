RSpec.describe "SPA" do
  it do
    visit "/"
    expect(page).to have_selector "h1", text: "Hello World! BROKEN ON PURPOSE TO TEST PIPELINE"
  end
end
