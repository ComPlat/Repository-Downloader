class ArrayXmlMapperBuilder
  def initialize(mapper_class, mappers)
    @mapper_class = mapper_class # Class AddressMapper
    @mappers = mappers # [Object AddressMapper, Object AddressMapper]
  end

  def build = object

  private

  def object = @object ||= klass_with_attribute.new(**{attribute_downcase_symbol => @mappers}) # AddressesMapper.new(address: [Object AddressMapper, Object AddressMapper])

  def klass_with_attribute
    @klass_with_attribute ||= -> {
      klass.public_send :attribute, attribute_downcase_symbol, @mapper_class, collection: true # attribute, :address, AddressMapper, collection: true
      klass # Class AddressesMapper
    }.call
  end

  # HINT: Avoid creating the same class twice!
  def klass = @klass ||= if Object.const_defined? klass_name
                Object.const_get klass_name # Class AddressesMapper
              else
                Object.const_set klass_name, Class.new(ShaleCustom::Mapper) # Class AddressesMapper
              end

  def klass_name = @klass_name ||= "#{attribute_upcase_string.pluralize}Mapper" # "AddressesMapper"

  def attribute_downcase_symbol = @attribute_downcase_symbol ||= attribute_upcase_string.downcase.to_sym # :address

  def attribute_upcase_string = @attribute_upcase_string ||= @mapper_class.name.gsub("Mapper", "") # "Address"
end
