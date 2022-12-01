module API
  module V1
    module Publications
      class Doi < Grape::API
        version "v1", using: :path

        namespace "/publications/doi" do
          desc "Get one publication via Doi", {produces: %w[application/json application/xml text/csv]}
          params { requires :doi, type: String, desc: "Doi" }
          get do
            dois = params[:doi].split(",")

            case dois.size
            when 0
              error!("Unprocessable Entity, 'doi'=#{params[:doi]} not valid", 422)
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
