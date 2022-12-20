class PublicationsBySearchPresenter
  # include HasToXml
  # include HasToJson

  def initialize(authors, contributor, description)
    @authors = authors
    @contributor = contributor
    @description = description
  end

  def publications = @publications ||= PublicationRepository.search(@authors, @contributor, @description)
end
