module API
  module V1
    module Publications
      class Doi < Grape::API
        version "v1", using: :path

        namespace "/publications/doi" do
          desc "Get one publication via Doi", {produces: %w[application/json application/xml text/csv]}
          params do
            requires :dois, type: Types::ValidDoiSet, desc: "Doi"
            requires :format, type: Types::SupportedRenderingFormat, desc: "Rendering Format"
          end
          get do
            stream PublicationsByDoiPresenter.new(params[:dois].value).public_send("to_#{params[:format].value}")
          end
        end

        route(:any, "*path") { error!("Not found", 404) }
      end
    end
  end
end
