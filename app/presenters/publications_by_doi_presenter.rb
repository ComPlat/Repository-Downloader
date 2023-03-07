class PublicationsByDoiPresenter
  include HasToXml
  include HasToJson
  include HasToZip
  include HasToCsv

  def initialize(dois) = @dois = dois

  def publications = @publications ||= PublicationRepository.where_dois(@dois)
end
