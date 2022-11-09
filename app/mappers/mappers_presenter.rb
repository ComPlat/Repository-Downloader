class MappersPresenter
  def initialize(mapper_class, mapper_args)
    @mapper_class = mapper_class # HINT: AddressMapper
    @mapper_args = mapper_args # HINT: [{ city: "Town", street: "Elm Street 1", zip: "12345" }]
  end

  def to_json = @to_json ||= @mapper_class.to_json(mappers)

  def to_xml = @to_xml ||= ArrayXmlMapperBuilder.new(@mapper_class, mappers).build.to_xml

  private

  def mappers = @mappers ||= @mapper_args.map { |mapper_arg| @mapper_class.new(**mapper_arg) }
end
