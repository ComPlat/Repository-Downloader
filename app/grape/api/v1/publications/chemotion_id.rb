module API
  module V1
    module Publications
      class ChemotionId < Grape::API
        version "v1", using: :path

        namespace "/publications/chemotion_id" do
          desc "Get one publication via ChemotionID", {produces: %w[application/json application/xml text/csv]}
          params { requires :id, type: String, desc: "ChemotionID" }
          route_param :id, type: String do
            get do
              ids = params[:id].split(",")

              case ids.size
              when 0
                error!("Unprocessable Entity, 'id'=#{params[:id]} not valid", 422)
              when 1
                present PublicationPresenter.present_by_chemotion_id ids.first
              else
                present PublicationsByChemotionIdPresenter.new ids
              end
            end
          end
        end

        route(:any, "*path") { error!("Not found", 404) }
      end
    end
  end
end
