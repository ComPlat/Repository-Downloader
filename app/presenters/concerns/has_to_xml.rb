module HasToXml
  extend ActiveSupport::Concern

  def to_xml
    Enumerator.new do |yielder|
      yielder << "<publications>"
      publications.each { |publication| publication.present_to_api.to_xml.each { |xml_chunk| yielder << xml_chunk } }
      yielder << "</publications>"
    end.lazy
  end
end
