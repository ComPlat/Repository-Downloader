class PublicationsByChemotionIdPresenter
  include HasToXml
  include HasToJson
  include HasToZip
  include HasToCsv

  def initialize(chemotion_ids) = @chemotion_ids = chemotion_ids

  def publications = @publications ||= PublicationRepository.where_chemotion_ids(@chemotion_ids)
end
