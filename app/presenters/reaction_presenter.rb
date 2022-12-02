class ReactionPresenter
  def initialize(reaction) = @reaction = reaction

  delegate :to_json, :to_xml, :to_csv, to: :mapper

  # TODO: Test and implement me!
  # HINT: Do not put the whole logic in here.
  def to_zip = nil

  private

  def mapper = @mapper ||= RootMappers::ReactionMapper.from_hash(model_to_mapper_adapter_hash)

  def model_to_mapper_adapter_hash = @model_to_mapper_adapter_hash ||= model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = @model_to_mapper_adapter ||= RootAdapters::ReactionToReactionMapperAdapter.new(@reaction)
end
