module ShaleCustom
  class Mapper < Shale::Mapper
    @json_mapping = Shale::Mapping::Dict.new(render_nil_default: true)
    @csv_mapping = Shale::Mapping::Dict.new(render_nil_default: true)
    @xml_mapping = ShaleCustom::Xml.new

    def self.from_hash(hash)
      raise ArgumentError, "hash needs to be a Hash" unless hash.is_a? Hash

      super hash.deep_stringify_keys
    end

    def initialize(**args)
      super(**args)
      self.class.instance_variable_get(:@xml_mapping).root self.class.name.demodulize.gsub("Mapper", "").camelize(:lower)
    end

    def to_csv(**args)
      super(**{headers: true}.merge(args))
    end
  end
end
