class PublicationSearchOperation
  ELEMENT_TYPES = %w[Container Reaction Sample].freeze

  def initialize(authors, contributor, description)
    @authors = authors
    @contributor = contributor
    @description = description
  end

  def search
    if @authors.present? || @contributor.present? || @description.present?
      Publication
        .where(element_type: ELEMENT_TYPES)
        .where(*authors_filter)
        .where(contributor_filter)
        .where(description_filter)
        .pluck :id
    else
      []
    end
  end

  private

  def authors_filter
    return [{}] unless @authors

    query = @authors.map { |_| "taggable_data @> any(array[?]::jsonb[])" }.join(" AND ")
    values = @authors.map { |author| {creators: [{name: author}]}.to_json }

    [query, *values]
  end

  def contributor_filter
    return {} unless @contributor

    ["taggable_data @> any(array[?]::jsonb[])", {contributors: {name: @contributor}}.to_json]
  end

  def description_filter
    return {} unless @description

    ["reaction_description LIKE ? OR sample_desc LIKE ?", "%#{@description}%", "%#{@description}%"]
  end
end
