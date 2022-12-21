class AnalysisPresenter
  def initialize(analysis) = @analysis = analysis

  def to_json = Enumerator.new { |yielder| yielder << mapper.to_json }

  def to_xml = Enumerator.new { |yielder| yielder << mapper.to_xml }

  def to_csv = Enumerator.new { |yielder| yielder << mapper.to_csv }

  def to_zip
    PublicationsByDoiPresenter.new([@analysis.doi]).to_zip
  end

  private

  def mapper = @mapper ||= RootMappers::AnalysisMapper.from_hash(model_to_mapper_adapter_hash)

  def model_to_mapper_adapter_hash = @model_to_mapper_adapter_hash ||= model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = @model_to_mapper_adapter ||= RootAdapters::AnalysisToAnalysisMapperAdapter.new(@analysis)
end
