class PublicationRepository
  DOI_FIELD_NAMES = [:doi, :analysis_doi].freeze
  JSONB_QUERY = "taggable_data @> any(array[?]::jsonb[])".freeze
  def self.find_by_doi!(doi) = Publication.find_by! JSONB_QUERY, DOI_FIELD_NAMES.map { |key| {key => doi}.to_json }

  def self.where_dois(dois) = Publication.where JSONB_QUERY, DOI_FIELD_NAMES.product(dois)
    .map { |field_name_doi_pair| {field_name_doi_pair.first => field_name_doi_pair.second}.to_json }

  def self.find_by_chemotion_id!(chemotion_id) = Publication.find chemotion_id

  def self.where_chemotion_ids(chemotion_ids) = Publication.where id: chemotion_ids
end
