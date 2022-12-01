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
              array = params[:id].split(",")

              error!("Unprocessable Entity, 'id'=#{params[:id]} not valid", 422) unless array.is_a? Array

              present PublicationPresenter.present_by_chemotion_id array.first.to_i if array.length == 1

              PublicationsPresenter.present_by_chemotion_ids(array.map { |chomotion_id| chomotion_id.to_i })
            end
          end
        end

        route(:any, "*path") { error!("Not found", 404) }
      end
    end
  end
end
