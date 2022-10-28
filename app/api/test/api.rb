module Test
  class API < Grape::API
    version 'v1', using: :path
    format :json
    prefix :api

    resource :test do
      desc 'Test message'
      get do
        books = 'Test message :)'
        present test
      end
    end
  end
end
