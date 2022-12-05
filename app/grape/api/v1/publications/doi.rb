module API
  module V1
    module Publications
      class Doi < Grape::API
        version "v1", using: :path

        namespace "/publications/doi" do
          desc "Get one publication via Doi", {produces: %w[application/json application/xml text/csv]}
          # TODO:
          #   Allows for full doi and splits of an list of dois correctly (with .../doi/?dois=...,...,...)
          #   .xml / .json can not be included with this the way we are doing it right now
          #   There seems to be an error with PublicationsByDoiPresenter when you enter multiple dois it returns []
          #   Specs not yet adjusted to the new code
          params do
            requires :doi,
              type: Array[String], coerce_with: ->(val) { val.split(",") },
              desc: "Doi"
          end
          get do
            dois = params[:doi]

            case dois.size
            when 0
              # TODO: grape has an Option for custom types which can validate this + our .to_i in 'requires :dois...'
              error!("Unprocessable Entity, 'id'=#{params[:dois]} not valid", 422)
            when 1
              present PublicationPresenter.present_by_doi dois.first
            else
              present PublicationsByDoiPresenter.new dois
            end
          end
        end

        route(:any, "*path") { error!("Not found", 404) }
      end
    end
  end
end
