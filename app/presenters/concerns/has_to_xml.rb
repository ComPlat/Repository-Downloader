module HasToXml
  extend ActiveSupport::Concern

  def to_xml
    @to_xml ||= "<publications>#{publications.map { |publication| publication.present_to_api.to_xml }.join("")}</publications>"
  end
end
