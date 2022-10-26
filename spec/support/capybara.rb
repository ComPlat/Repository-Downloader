HUB_URL = ENV["HUB_URL"].freeze

return unless HUB_URL

Capybara.register_driver :headless_selenium_chrome_in_container do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome
  Capybara::Selenium::Driver.new(app, browser: :remote, url: HUB_URL, capabilities:)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    Capybara.server_host = "0.0.0.0"
    Capybara.server_port = 4000
    Capybara.app_host = "http://web:4000"
    driven_by(:headless_selenium_chrome_in_container)
  end
end
