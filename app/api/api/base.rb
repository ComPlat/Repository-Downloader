module API
  class Base < Grape::API
    format :json

    mount API::Messages
    add_swagger_documentation
  end
end
