class PublicationsBySearchPresenter
  include HasToXml
  include HasToJson

  def initialize(params) = @params = params

  def publications = @publications ||= PublicationRepository.search(@params)
end
