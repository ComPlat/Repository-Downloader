# Overwrites the defaults for the Swagger UI
GrapeSwaggerRails.options.url = "api/swagger_doc.json"
# noinspection RubyResolve
GrapeSwaggerRails.options.app_url = ENV.fetch("SWAGGER_UI") { "http://localhost:3000/" }
