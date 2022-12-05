module API
  module V1
    module Publications
      class ChemotionId < Grape::API
        version "v1", using: :path

        namespace "/publications/chemotion_id" do
          desc "Get publication(s) via ChemotionID(s)", {produces: %w[application/json application/xml text/csv application/zip]}
          params do
            requires :ids, type: Types::PositiveIntegerSet, desc: "ChemotionID"
            requires :format, type: Types::SupportedRenderingFormat, desc: "Rendering Format"
          end
          get do
            stream PublicationsByChemotionIdPresenter.new(params[:ids].value).public_send("to_#{params[:format].value}")
          end

          route(:any, "*path") { error!("Not found", 404) }
        end
      end
    end
  end
end
