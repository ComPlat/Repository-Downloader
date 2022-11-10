module API
  module V1
    module Publication
      class ChemotionId < Grape::API
        version "v1", using: :path

        namespace "/publication/:chemotion_id" do
          desc "Return list of records"
          get do
            args = {city: "Town", street: "Chemotion Street 1", zip: "12345"}
            present MappersPresenter.new AddressMapper, [args, args]
          end

          desc "Get one record via ChemotionID"
          params do
            requires :id, type: Integer, desc: "ChemotionID"
          end
          route_param :id, type: Integer do
            get do
              if params[:id] == 1
                AddressMapper.new city: "Town", street: "Chemotion Street 1", zip: "12345"
              else
                error!("Invalid message: #{params[:id]}", 404) unless present
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
