module API
  class Base < Grape::API
    rescue_from ActiveRecord::RecordNotFound do |error|
      error! error.message, 404
    end

    format :json

    content_type :xml, "application/xml"
    formatter :xml, ->(object, _env) { object.to_xml }

    content_type :json, "application/json"
    formatter :json, ->(object, _env) { object.to_json }

    content_type :csv, "text/csv"
    formatter :csv, ->(object, _env) { object.to_csv }

    # TODO: Add content_type :zip

    # HINT: Needed to avoid CORS (Cross-Origin Resource Sharing) error.
    #       Swagger UI returns response code 0 if these lines aren't here.
    before do
      header["Access-Control-Allow-Origin"] = "*"
      header["Access-Control-Request-Method"] = "*"
    end

    mount API::V1::Publications::Base

    add_swagger_documentation
  end
end
