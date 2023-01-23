# frozen_string_literal: true

class XmlsStreamable
  def initialize(publications) = @publications = publications

  def each
    yield "<publications>"

    @publications.find_each { |publication| publication.present_to_api.to_xml.each { |chunk| yield chunk } }

    yield "</publications>"
  end
end
