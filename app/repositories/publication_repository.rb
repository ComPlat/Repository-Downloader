class PublicationRepository
  def self.find_by_doi!(doi) = Publication.find_by!("taggable_data @> ?", {doi:}.to_json)

  def self.find_by_chemotion_id!(chemotion_id) = Publication.find chemotion_id
end
