module API
  class Messages < Grape::API
    namespace :messages do
      desc "Return list of messages"
      get do
        address = AddressMapper.new city: "Town", street: "Elm Street 1", zip: "12345"
        present AddressesPresenter.new [address, address]
      end

      desc "Return a message"
      params do
        requires :id, type: Integer, desc: "Message ID"
      end
      route_param :id, type: Integer do
        get do
          if true
            present AddressMapper.new city: "Town", street: "Elm Street 1", zip: "12345"
          else
            error!("Invalid message: #{params[:id]}", 404)
          end
        end
      end
    end

    route :any, "*path" do
      error!("Not found", 404)
    end
  end
end
