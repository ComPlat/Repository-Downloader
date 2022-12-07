class PublicationRepository
  def self.find_by_doi!(doi) = Publication.find_by!("taggable_data @> ?", {doi:}.to_json)

  def self.where_dois(dois)
    Publication.where("taggable_data @> any(array[?]::jsonb[])", dois.map { |doi| {doi: doi}.to_json })
  end

  def self.find_by_chemotion_id!(chemotion_id) = Publication.find chemotion_id

  def self.where_chemotion_ids(chemotion_ids) = Publication.where id: chemotion_ids
end
