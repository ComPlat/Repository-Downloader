require "bag_it_stream"

class SamplePresenter
  def initialize(sample) = @sample = sample

  def to_json = Enumerator.new { |yielder| yielder << mapper.to_json }

  def to_xml = Enumerator.new { |yielder| yielder << mapper.to_xml }

  def to_csv = Enumerator.new { |yielder| yielder << mapper.to_csv }

  def to_zip
    # TODO: Implement unique path
    # TODO: Use ActiveJob for cleanup
    FileUtils.rm_rf "tmp/data/input"
    FileUtils.mkpath "tmp/data/input"
    BagItStream.new({"sample.json" => StringIO.open(mapper.to_json),
                      "sample.xml" => StringIO.open(mapper.to_xml),
                      "sample.csv" => StringIO.open(mapper.to_csv)},
      "tmp/data/input").rack_body
  end

  private

  def mapper = @mapper ||= RootMappers::SampleMapper.from_hash(model_to_mapper_adapter_hash)

  def model_to_mapper_adapter_hash = @model_to_mapper_adapter_hash ||= model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = @model_to_mapper_adapter ||= RootAdapters::SampleToSampleMapperAdapter.new(@sample)
end
