module HasToXml
  extend ActiveSupport::Concern

  def to_xml
    XmlsStreamable.new(publications)
  end
end
