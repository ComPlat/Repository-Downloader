module ShaleCustom
  class Mapper < Shale::Mapper
    @json_mapping = Shale::Mapping::Dict.new(render_nil_default: true)
    @csv_mapping = Shale::Mapping::Dict.new(render_nil_default: true)
    @xml_mapping = ShaleCustom::Xml.new

    def to_csv(headers: true)
      super
    end

    def initialize(**args)
      super(**args)
      self.class.instance_variable_get(:@xml_mapping).root self.class.name.gsub("Mapper", "").downcase
    end
  end
end
