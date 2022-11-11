class PublicationRepository
  def self.find_by_doi!(doi) = Publication.find_by!("taggable_data @> ?", {doi:}.to_json)

  # HINT: id is NOT the primary key of toap_publications, because it has none!
  # rubocop:disable Rails/FindById
  def self.find_by_chemotion_id!(chemotion_id) = Publication.find_by!(id: chemotion_id)
end
