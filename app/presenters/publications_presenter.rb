class PublicationsPresenter
  def self.present_by_dois(dois) = dois.map { |doi| PublicationPresenter.present_by_doi doi }

  def self.present_by_chemotion_ids(chemotion_ids) = NewMappersPresenter.new(Publication.where(id: chemotion_ids))

  # rubocop:enable Rails/DynamicFindBy
end
