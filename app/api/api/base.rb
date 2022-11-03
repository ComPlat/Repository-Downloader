module API
  class Base < Grape::API
    content_type :json, "application/json"
    content_type :xml, "application/xml"

    # HINT: Needed to avoid CORS (Cross-Origin Resource Sharing) error.
    #       Swagger UI returns response code 0 if these lines aren't here.
    before do
      header["Access-Control-Allow-Origin"] = "*"
      header["Access-Control-Request-Method"] = "*"
    end

    mount API::Messages
    add_swagger_documentation
  end
end
