module API
  module V1
    module Publications
      DOI_PREFIX = "10.14272/"

      class Doi < Grape::API
        version "v1", using: :path

        namespace "/publications/doi" do
          desc "Get one publication via Doi", {produces: %w[application/json application/xml text/csv]}
          params { requires :doi, type: String, desc: "Doi" }
          get do
            puts params[:doi]

            array = params[:doi].split(",")

            error!("Unprocessable Entity, 'doi'=#{params[:doi]} not valid", 422) if array.length == 0

            present PublicationPresenter.present_by_doi DOI_PREFIX + array.first if array.length == 1

            # array.map { |doi| PublicationPresenter.present_by_doi DOI_PREFIX + doi }
          end
        end

        route(:any, "*path") { error!("Not found", 404) }
      end
    end
  end
end
