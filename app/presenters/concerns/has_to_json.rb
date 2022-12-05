module HasToJson
  extend ActiveSupport::Concern

  def to_json
    Enumerator.new do |yielder|
      yielder << "["
      publications.each.with_index(1) { |publication, index|
        publication.present_to_api.to_json.each { |json_chunk|
          yielder << (index < publications_size ? "#{json_chunk}," : json_chunk)
        }
      }
      yielder << "]"
    end
  end

  private

  def publications_size
    @publications_size ||= publications.size
  end
end
