RSpec.describe "Very long query string" do
  it do
    visit "/api/v1/publications?chemotion_ids=#{(1..10).to_a.join(",")}&format=zip"

    expect(page).not_to have_text "HTTP ERROR 400"
  end

  it do
    visit "/api/v1/publications?chemotion_ids=#{(1..100).to_a.join(",")}&format=zip"

    expect(page).not_to have_text "HTTP ERROR 400"
  end

  it do
    visit "/api/v1/publications?chemotion_ids=#{(1..1000).to_a.join(",")}&format=zip"

    expect(page).not_to have_text "HTTP ERROR 400"
  end

  it do
    visit "/api/v1/publications?chemotion_ids=#{(1..2000).to_a.join(",")}&format=zip"

    expect(page).not_to have_text "HTTP ERROR 400"
  end

  it do
    visit "/api/v1/publications?chemotion_ids=#{(1..2500).to_a.join(",")}&format=zip"

    expect(page).not_to have_text "HTTP ERROR 400"
  end

  it do
    visit "/api/v1/publications?chemotion_ids=#{(1..3000).to_a.join(",")}&format=zip"

    expect(page).not_to have_text "HTTP ERROR 400"
  end

  it do
    visit "/api/v1/publications?chemotion_ids=#{(1..10000).to_a.join(",")}&format=zip"

    expect(page).not_to have_text "HTTP ERROR 400"
  end

  it do
    visit "/api/v1/publications?chemotion_ids=#{(1..20000).to_a.join(",")}&format=zip"

    expect(page).not_to have_text "HTTP ERROR 400"
  end

  it do
    visit "/api/v1/publications?chemotion_ids=#{(1..21000).to_a.join(",")}&format=zip"

    expect(page).to have_text "HTTP ERROR 400"
  end
end
