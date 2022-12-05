class SamplePresenter
  def initialize(sample) = @sample = sample

  def to_json = Enumerator.new { |yielder| yielder << mapper.to_json }

  def to_xml = Enumerator.new { |yielder| yielder << mapper.to_xml }

  def to_csv = Enumerator.new { |yielder| yielder << mapper.to_csv }

  # TODO: Instead give the correct zip stream from bagitstream gem.
  def to_zip = Enumerator.new { |yielder| yielder << "" }

  private

  def mapper = @mapper ||= RootMappers::SampleMapper.from_hash(model_to_mapper_adapter_hash)

  def model_to_mapper_adapter_hash = @model_to_mapper_adapter_hash ||= model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = @model_to_mapper_adapter ||= RootAdapters::SampleToSampleMapperAdapter.new(@sample)
end
