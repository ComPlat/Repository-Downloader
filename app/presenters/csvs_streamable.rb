# frozen_string_literal: true

class CsvsStreamable
  def initialize(publications) = @publications = publications

  def each
    yield CsvMerger.new(@publications.map { |publication| publication.present_to_api.to_csv.to_a.join }).merged_csv_string
  end
end
