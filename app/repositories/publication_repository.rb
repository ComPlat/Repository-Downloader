class PublicationRepository
  DOI_FIELD_NAMES = [:doi, :analysis_doi].freeze
  JSONB_QUERY = "taggable_data @> any(array[?]::jsonb[])".freeze
  ELEMENT_TYPES = %w[Container Reaction Sample].freeze

  def self.where_dois(dois) = Publication.where(element_type: ELEMENT_TYPES)
    .where(JSONB_QUERY, DOI_FIELD_NAMES.product(dois)
    .map { |field_name_doi_pair| {field_name_doi_pair.first => field_name_doi_pair.second}.to_json })

  def self.where_chemotion_ids(chemotion_ids) = Publication.where(id: chemotion_ids, element_type: ELEMENT_TYPES)

  def self.search(authors, contributor, description)
    PublicationSearchOperation.new(authors, contributor, description).search
  end
end
