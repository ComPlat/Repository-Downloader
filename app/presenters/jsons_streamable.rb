# frozen_string_literal: true

class JsonsStreamable
  def initialize(publications) = @publications = publications

  def each
    yield "["

    @publications.find_each.with_index(1) do |publication, index|
      publication.present_to_api.to_json.each do |json_chunk|
        yield ((index < publications_size) ? "#{json_chunk}," : json_chunk)
      end
    end

    yield "]"
  end

  private

  def publications_size = @publications_size ||= @publications.size
end
