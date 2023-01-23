module HasToXml
  extend ActiveSupport::Concern

  def to_xml
    # Enumerator.new do |yielder|
    #   yielder << "<publications>"
    #   publications.each { |publication| publication.present_to_api.to_xml.each { |xml_chunk| yielder << xml_chunk } }
    #   yielder << "</publications>"
    # end.lazy

    # publications.map { |publication| publication.present_to_api.to_xml.to_a.join }

    Class.new {
      def initialize(publications) = @publications = publications

      def each
        yield "<publications>"

        @publications.find_each do |publication|
          publication.present_to_api.to_xml.each { |chunk| yield chunk }
        end

        yield "</publications>"
      end
    }.new(publications)
  end
end
