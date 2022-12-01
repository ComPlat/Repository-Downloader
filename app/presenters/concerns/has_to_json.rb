module HasToJson
  extend ActiveSupport::Concern

  def to_json = @to_json ||= publications.map { |publication| publication.present_to_api }.to_json
end
