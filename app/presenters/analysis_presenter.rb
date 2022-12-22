class AnalysisPresenter
  def initialize(analysis) = @analysis = analysis

  def to_json = Enumerator.new { |yielder| yielder << mapper.to_json }.lazy

  def to_xml = Enumerator.new { |yielder| yielder << mapper.to_xml }.lazy

  def to_csv = Enumerator.new { |yielder| yielder << mapper.to_csv }.lazy

  private

  def mapper = @mapper ||= RootMappers::AnalysisMapper.from_hash(model_to_mapper_adapter_hash)

  def model_to_mapper_adapter_hash = @model_to_mapper_adapter_hash ||= model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = @model_to_mapper_adapter ||= RootAdapters::AnalysisToAnalysisMapperAdapter.new(@analysis)
end
