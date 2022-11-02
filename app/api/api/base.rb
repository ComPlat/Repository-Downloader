require "grape-swagger"

module API
  class Base < Grape::API
    format :json

    before do
      header["Access-Control-Allow-Origin"] = "*"
      header["Access-Control-Request-Method"] = "*"
    end

    mount API::Messages
    add_swagger_documentation
  end
end
