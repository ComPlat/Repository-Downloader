module API
  class Base < Grape::API
    rescue_from ActiveRecord::RecordNotFound do |error|
      error! error.message, 404
    end

    # HINT: It is the MIME type, see: https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types
    content_type :json, "application/json"
    formatter :json, ->(object, _env) { object.to_json }

    content_type :csv, "text/csv"
    formatter :csv, ->(object, _env) { object.to_csv }

    content_type :zip, "application/zip"
    formatter :zip, ->(object, _env) { object.to_zip }

    content_type :xml, "application/xml"
    formatter :xml, ->(object, _env) { object.to_xml }

    default_format :json

    # HINT: When you call an API endpoint from a modern browser,
    #       it will show XML. This is not a bug in our API,
    #       but the browsers send Headers that actually want XML.
    # TODO: Write tests that proof this. We already checked by hand with curl (produces JSON, JSON, and XML - all as intended):
    #       curl -X 'GET' 'http://localhost:3000/api/v1/publications?chemotion_ids=1'
    #       curl -X 'GET' 'http://localhost:3000/api/v1/publications?chemotion_ids=1' -H 'accept: application/json'
    #       curl -X 'GET' 'http://localhost:3000/api/v1/publications?chemotion_ids=1'-H 'accept: application/xml

    # HINT: Needed to avoid CORS (Cross-Origin Resource Sharing) error.
    #       Swagger UI returns response code 0 if these lines aren't here.
    before do
      header["Access-Control-Allow-Origin"] = "*"
      header["Access-Control-Request-Method"] = "*"
    end

    mount API::V1::Publications

    add_swagger_documentation doc_version: "v1", info: {title: "Chemotion Repository Downloader"}
  end
end
