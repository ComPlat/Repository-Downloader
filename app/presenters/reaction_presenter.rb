require "bag_it_stream"

class ReactionPresenter
  def initialize(reaction) = @reaction = reaction

  def to_json = Enumerator.new { |yielder| yielder << mapper.to_json }

  def to_xml = Enumerator.new { |yielder| yielder << mapper.to_xml }

  def to_csv = Enumerator.new { |yielder| yielder << mapper.to_csv }

  def to_zip
    # TODO: Implement unique path
    # TODO: Use ActiveJob for cleanup
    FileUtils.rm_rf "tmp/data/input"
    FileUtils.mkpath "tmp/data/input"
    BagItStream.new({"reaction.json" => StringIO.open(mapper.to_json),
                      "reaction.xml" => StringIO.open(mapper.to_xml),
                      "reaction.csv" => StringIO.open(mapper.to_csv)},
      "tmp/data/input").rack_body
  end

  private

  def mapper = @mapper ||= RootMappers::ReactionMapper.from_hash(model_to_mapper_adapter_hash)

  def model_to_mapper_adapter_hash = @model_to_mapper_adapter_hash ||= model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = @model_to_mapper_adapter ||= RootAdapters::ReactionToReactionMapperAdapter.new(@reaction)
end
