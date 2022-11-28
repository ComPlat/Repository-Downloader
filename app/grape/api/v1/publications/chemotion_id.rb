module API
  module V1
    module Publications
      class ChemotionId < Grape::API
        version "v1", using: :path

        namespace "/publications/chemotion_id" do
          desc "Get one publication via ChemotionID", {produces: %w[application/json application/xml text/csv]}
          params { requires :id, type: Integer, desc: "ChemotionID" }
          route_param :id, type: Integer do
            get { present PublicationPresenter.present_by_chemotion_id params[:id] }
          end
        end

        route(:any, "*path") { error!("Not found", 404) }
      end
    end
  end
end
