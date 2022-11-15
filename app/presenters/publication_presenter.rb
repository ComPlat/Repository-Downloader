class PublicationPresenter
  # rubocop:disable Rails/DynamicFindBy
  def self.present_by_doi(doi) = AnalysisRepository.find_by_doi!(doi).present_to_api

  def self.present_by_chemotion_id(chemotion_id) = AnalysisRepository.find_by_chemotion_id!(chemotion_id).present_to_api
end
