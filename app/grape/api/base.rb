module API
  class Base < Grape::API
    rescue_from ActiveRecord::RecordNotFound do |error|
      error! error.message, 404
    end

    format :json

    content_type :xml, "application/xml" # HINT: It is the MIME type, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
    formatter :xml, ->(object, _env) { object.to_xml }

    content_type :json, "application/json"
    formatter :json, ->(object, _env) { object.to_json }

    content_type :csv, "text/csv"
    formatter :csv, ->(object, _env) { object.to_csv }

    content_type :zip, "application/zip"
    formatter :zip, ->(object, _env) { object.to_zip }

    # HINT: Needed to avoid CORS (Cross-Origin Resource Sharing) error.
    #       Swagger UI returns response code 0 if these lines aren't here.
    before do
      header["Access-Control-Allow-Origin"] = "*"
      header["Access-Control-Request-Method"] = "*"
    end

    mount API::V1::Publications::Base

    add_swagger_documentation array_use_braces: false
  end
end
