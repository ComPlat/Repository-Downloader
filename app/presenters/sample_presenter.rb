class SamplePresenter
  def initialize(sample) = @sample = sample

  def to_json = Enumerator.new { |yielder| yielder << mapper.to_json }

  def to_xml = Enumerator.new { |yielder| yielder << mapper.to_xml }

  def to_csv = Enumerator.new { |yielder| yielder << mapper.to_csv }

  def to_zip
    unix_timestamp_in_ns = (Time.current.to_r * 1000).round
    path = "./tmp/bagit/#{unix_timestamp_in_ns}-#{@sample.chemotion_id}_##{SecureRandom.uuid}"
    FileUtils.mkpath path
    BagItStream.new({"sample.json" => StringIO.open(mapper.to_json),
                      "sample.xml" => StringIO.open(mapper.to_xml),
                      "sample.csv" => StringIO.open(mapper.to_csv)},
      path, false).rack_body
  end

  private

  def mapper = @mapper ||= RootMappers::SampleMapper.from_hash(model_to_mapper_adapter_hash)

  def model_to_mapper_adapter_hash = @model_to_mapper_adapter_hash ||= model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = @model_to_mapper_adapter ||= RootAdapters::SampleToSampleMapperAdapter.new(@sample)
end
