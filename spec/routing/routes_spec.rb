describe "Rails.application.routes.draw" do
  it { expect(get: "/").to route_to(controller: "spa", action: "index") }
  it { expect(get: "/swagger").to route_to(controller: "grape_swagger_rails/application", action: "index") }
  it { expect(get: "/does_not_exists").not_to be_routable }
end
