class PublicationSearchOperation
  SEARCH_OPERATOR_LIKE = "LIKE".freeze
  SEARCH_OPERATOR_EQUAL = "EQUAL".freeze
  ELEMENT_TYPES = %w[Container Reaction Sample].freeze
  SQL_TEMPLATE_TAGGABLE_DATA_HAS = "taggable_data @> any(array[?]::jsonb[])".freeze
  SQL_TEMPLATE_CREATOR_LIKE = "json_extract_path_text(taggable_data::json, 'creators')::text like ?".freeze
  SQL_TEMPLATE_CONTRIBUTOR_LIKE = "taggable_data->'contributors'->>'name'::text like ?".freeze
  SQL_TEMPLATE_DESCRIPTION = "reaction_description LIKE ? OR sample_desc LIKE ?".freeze
  SQL_SUBQUERY_JOINER = " AND ".freeze

  def initialize(params)
    @params = params
  end

  def search
    return [] unless authors_value.present? || contributor_value.present? || description_value.present?

    filtered = Publication.where(element_type: ELEMENT_TYPES)
    filtered = filtered.where(authors_filter) if authors_value.present? && authors_search_operator.present?
    filtered = filtered.where(contributor_filter) if contributor_value.present? && contributor_search_operator.present?
    filtered = filtered.where(description_filter) if description_value.present? && description_search_operator.present?
    filtered.pluck :id
  end

  private

  def authors_filter
    [query_to_authors.map { |h| h.keys.first }.join(SQL_SUBQUERY_JOINER), *query_to_authors.map { |h| h.values.first }]
  end

  def query_to_authors
    @query_to_authors ||= authors_search_operator.zip(authors_value).to_h.map do |operator, author|
      {query(operator) => author(author, operator)}
    end
  end

  def query(operator)
    case operator
    when SEARCH_OPERATOR_LIKE
      SQL_TEMPLATE_CREATOR_LIKE
    when SEARCH_OPERATOR_EQUAL
      SQL_TEMPLATE_TAGGABLE_DATA_HAS
    else
      raise NotImplementedError("Operator #{operator} is not implemented")
    end
  end

  def author(author, operator)
    case operator
    when SEARCH_OPERATOR_LIKE
      "%#{author}%"
    when SEARCH_OPERATOR_EQUAL
      {creators: [{name: author}]}.to_json
    else
      raise NotImplementedError("Operator #{operator} is not implemented")
    end
  end

  def contributor_filter
    case contributor_search_operator
    when SEARCH_OPERATOR_LIKE
      [SQL_TEMPLATE_CONTRIBUTOR_LIKE, "%#{contributor_value}%"]
    when SEARCH_OPERATOR_EQUAL
      [SQL_TEMPLATE_TAGGABLE_DATA_HAS, {contributors: {name: contributor_value}}.to_json]
    else
      raise NotImplementedError("Operator #{contributor_search_operator} is not implemented")
    end
  end

  def description_filter
    case description_search_operator
    when SEARCH_OPERATOR_LIKE
      [SQL_TEMPLATE_DESCRIPTION, "%#{description_value}%", "%#{description_value}%"]
    when SEARCH_OPERATOR_EQUAL
      [SQL_TEMPLATE_DESCRIPTION, description_value, description_value]
    else
      raise NotImplementedError("Operator #{description_search_operator} is not implemented")
    end
  end

  def authors_value = @authors_value ||= @params[:authors_value]

  def authors_search_operator = @authors_search_operator ||= @params[:authors_search_operator]

  def contributor_value = @contributor_value ||= @params[:contributor_value]

  def contributor_search_operator = @contributor_search_operator ||= @params[:contributor_search_operator]

  def description_value = @description_value ||= @params[:description_value]

  def description_search_operator = @description_search_operator ||= @params[:description_search_operator]
end
