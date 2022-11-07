class MappersPresenter
  def initialize(mapper_class, mapper_args)
    @mapper_class = mapper_class # HINT: AddressMapper
    @mapper_args = mapper_args # HINT: [{ city: "Town", street: "Elm Street 1", zip: "12345" }]
  end

  def to_json = @to_json ||= @mapper_class.to_json(mappers)

  def to_xml = @to_xml ||= array_xml_mapper.to_xml

  def mappers = @mappers ||= @mapper_args.map { |mapper_arg| @mapper_class.new(**mapper_arg) }

  def array_xml_mapper
    @array_xml_mapper ||= -> {
      unmapperized_class_name = @mapper_class.name.gsub("Mapper", "") # "Address"
      attribute = unmapperized_class_name.downcase.to_sym # :address
      klass_name = "#{unmapperized_class_name.pluralize}Mapper" # "AddressesMapper"
      array_xml_mapper_class = Object.const_set klass_name, Class.new(ShaleCustom::Mapper) # Class AddressesMapper
      array_xml_mapper_class.public_send :attribute, attribute, @mapper_class, collection: true # attribute, :address, AddressMapper, collection: true
      array_xml_mapper_class.new(**{attribute => mappers}) # AddressesMapper.new(address: [AddressMapper, AddressMapper])
    }.call
  end
end
