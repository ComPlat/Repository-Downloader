module API
  module V1
    module Publications
      class Doi < Grape::API
        version "v1", using: :path

        namespace "/publications/:doi" do
          desc "Return list of DOIs"
          get do
            args = {city: "Town", street: "Doi Street 1", zip: "12345"}
            present MappersPresenter.new AddressMapper, [args, args]
          end

          desc "Get one record via DOI"
          params do
            requires :doi_id, type: Integer, desc: "DOI"
          end
          route_param :doi_id, type: Integer do
            get do
              if params[:doi_id] == 1
                AddressMapper.new city: "Town", street: "Doi Street 1", zip: "12345"
              else
                error!("Invalid message: #{params[:doi_id]}", 404) unless present
              end
            end
          end
        end

        route :any, "*path" do
          error!("Not found", 404)
        end
      end
    end
  end
end
