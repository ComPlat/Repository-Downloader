class SamplePresenter
  def initialize(sample) = @sample = sample

  delegate :to_json, :to_xml, :to_csv, to: :mapper

  # TODO: Implement me!
  # HINT: Do not put the whole logic in here.
  def to_zip = nil

  private

  def mapper = @mapper ||= RootMappers::SampleMapper.from_hash(model_to_mapper_adapter_hash)

  def model_to_mapper_adapter_hash = @model_to_mapper_adapter_hash ||= model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = @model_to_mapper_adapter ||= RootAdapters::SampleToSampleMapperAdapter.new(@sample)
end
