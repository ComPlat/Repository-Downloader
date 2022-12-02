# TODO: Test me!
# TODO: Use me in Sample model.
# TODO: Replicate me and test me for Analysis and Reaction.
class SamplePresenter
  def initialize(sample) = @sample = sample

  delegate :to_json, :to_xml, :to_csv, to: :mapper

  def to_zip
    nil
    # TODO: Test and implement me!
    # HINT: Do not put the whole logic in here.
  end

  private

  def mapper
    RootMappers::SampleMapper.from_hash model_to_mapper_adapter_hash
  end

  def model_to_mapper_adapter_hash = model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = RootAdapters::SampleToSampleMapperAdapter.new @sample
end
