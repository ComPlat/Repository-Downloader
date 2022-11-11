module API
  module V1
    class Search < Grape::API
      version "v1", using: :path

      namespace :search do
        desc "Return result of search"
        params do
          requires :id, type: Integer, desc: "Search"
          requires :address, type: String
          end
        end
      post "search?=id=:id&address=:address" do
        if params[:id] == 1 && params[:address] == "address"
          AddressMapper.new city: "Town", street: "Search Street 1", zip: "12345"
        else
          error!("Invalid message: #{params[:id]}", 404) unless present
        end
      end
      end

      route :any, "*path" do
        error!("Not found", 404)
      end
    end
  end
end
