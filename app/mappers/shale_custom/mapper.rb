module ShaleCustom
  class Mapper < Shale::Mapper
    @json_mapping = Shale::Mapping::Dict.new(render_nil_default: true)
    @csv_mapping = Shale::Mapping::Dict.new(render_nil_default: true)
    @xml_mapping = ShaleCustom::Xml.new

    def self.inherited(subclass)
      super.root subclass.to_s.gsub("Mapper", "").downcase
    end
  end
end
