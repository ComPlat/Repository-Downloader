class PublicationSearchOperation
  ELEMENT_TYPE_FILTER = {element_type: "Collection"}.freeze

  def initialize(authors, contributor, description)
    @authors = authors
    @contributor = contributor
    @description = description
  end

  def search
    Publication
      .where.not(ELEMENT_TYPE_FILTER)
      .where(*authors_filter)
      .where(contributor_filter)
      .where(description_filter)
      .pluck :id
  end

  private

  def authors_filter
    return [{}] unless @authors

    query = @authors.map { |author| "taggable_data @> any(array[?]::jsonb[])" }.join(" AND ")
    values = @authors.map { |author| {creators: [{name: author}]}.to_json }

    [query, *values]
  end

  def contributor_filter
    return {} unless @contributor

    ["taggable_data @> any(array[?]::jsonb[])", {contributors: {name: @contributor}}.to_json]
  end

  def description_filter
    return {} unless @description

    # TODO: Also search in extended_metadata::content for the description of the analysis?
    ["reaction_description LIKE ? OR sample_desc LIKE ?", "%#{@description}%", "%#{@description}%"]
  end
end
