class PublicationsByDoiPresenter
  include HasToXml
  include HasToJson

  def initialize(dois) = @dois = dois

  def publications = @publications ||= PublicationRepository.where_dois(@dois)
end
