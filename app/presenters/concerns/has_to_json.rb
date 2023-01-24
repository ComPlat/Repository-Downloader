module HasToJson
  extend ActiveSupport::Concern

  def to_json
    JsonsStreamable.new(publications)
  end
end
