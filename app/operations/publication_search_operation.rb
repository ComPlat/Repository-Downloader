class PublicationSearchOperation
  ELEMENT_TYPES = %w[Container Reaction Sample].freeze
  SQL_TEMPLATE_TAGGABLE_DATA = "taggable_data @> any(array[?]::jsonb[])".freeze

  def initialize(authors, contributor, description)
    @authors = authors
    @contributor = contributor
    @description = description
  end

  def search
    return [] unless @authors.present? || @contributor.present? || @description.present?

    Publication
      .where(element_type: ELEMENT_TYPES)
      .where(*authors_filter)
      .where(contributor_filter)
      .where(description_filter)
      .pluck :id
  end

  private

  def authors_filter
    return [{}] unless @authors

    query = (Array.new @authors.size, SQL_TEMPLATE_TAGGABLE_DATA).join(" AND ")
    values = @authors.map { |author| {creators: [{name: author}]}.to_json }

    [query, *values]
  end

  def contributor_filter
    return {} unless @contributor

    [SQL_TEMPLATE_TAGGABLE_DATA, {contributors: {name: @contributor}}.to_json]
  end

  def description_filter
    return {} unless @description

    ["reaction_description LIKE ? OR sample_desc LIKE ?", "%#{@description}%", "%#{@description}%"]
  end
end
