class ReactionPresenter
  def initialize(reaction) = @reaction = reaction

  def to_json = Enumerator.new { |yielder| yielder << mapper.to_json }

  def to_xml = Enumerator.new { |yielder| yielder << mapper.to_xml }

  def to_csv = Enumerator.new { |yielder| yielder << mapper.to_csv }

  def to_zip
    PublicationsByDoiPresenter.new([@reaction.doi]).to_zip
  end

  private

  def mapper = @mapper ||= RootMappers::ReactionMapper.from_hash(model_to_mapper_adapter_hash)

  def model_to_mapper_adapter_hash = @model_to_mapper_adapter_hash ||= model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = @model_to_mapper_adapter ||= RootAdapters::ReactionToReactionMapperAdapter.new(@reaction)
end
