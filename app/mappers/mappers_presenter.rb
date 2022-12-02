class MappersPresenter
  def initialize(mapper_class, mapper_args)
    raise ArgumentError, "mapper_class needs to be a ShaleCustom::Mapper" unless mapper_class <= ShaleCustom::Mapper
    raise ArgumentError, "mapper_args needs to be an Array, but it is a #{mapper_args.class}" unless mapper_args.is_a? Array
    raise ArgumentError, "each element of mapper_args needs to be a Hash" unless mapper_args.all? Hash

    @mapper_class = mapper_class # HINT: AddressMapper
    @mapper_args = mapper_args # HINT: [{ city: "Town", street: "Elm Street 1", zip: "12345" }]
  end

  def to_json = @to_json ||= @mapper_class.to_json(mappers)

  def to_xml = @to_xml ||= ArrayXmlMapperBuilder.new(@mapper_class, mappers).build.to_xml

  private

  def mappers = @mappers ||= @mapper_args.map { |mapper_arg| @mapper_class.from_hash mapper_arg }
end
