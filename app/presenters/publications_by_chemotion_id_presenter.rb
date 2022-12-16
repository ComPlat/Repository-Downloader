class PublicationsByChemotionIdPresenter
  include HasToXml
  include HasToJson

  def initialize(chemotion_ids) = @chemotion_ids = chemotion_ids

  def publications = @publications ||= PublicationRepository.where_chemotion_ids(@chemotion_ids)
end
