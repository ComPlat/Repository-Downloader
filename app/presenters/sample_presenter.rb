class SamplePresenter
  def initialize(sample) = @sample = sample

  def to_json = Enumerator.new { |yielder| yielder << mapper.to_json }

  def to_xml = Enumerator.new { |yielder| yielder << mapper.to_xml }

  def to_csv = Enumerator.new { |yielder| yielder << mapper.to_csv }

  def to_zip
    create_bag_it_path
    bag_it_stream.rack_body
  end

  private

  def mapper = @mapper ||= RootMappers::SampleMapper.from_hash(model_to_mapper_adapter_hash)

  def model_to_mapper_adapter_hash = @model_to_mapper_adapter_hash ||= model_to_mapper_adapter.to_h

  def model_to_mapper_adapter = @model_to_mapper_adapter ||= RootAdapters::SampleToSampleMapperAdapter.new(@sample)

  def bag_it_stream
    BagItStream.new({"sample.json" => StringIO.open(mapper.to_json),
                      "sample.xml" => StringIO.open(mapper.to_xml),
                      "sample.csv" => StringIO.open(mapper.to_csv)},
      bag_it_path, false)
  end

  def bag_it_path
    unix_timestamp_in_ns = (Time.current.to_r * 1000).round
    "./tmp/bagit/#{unix_timestamp_in_ns}-#{@sample.chemotion_id}_##{SecureRandom.uuid}"
  end

  def create_bag_it_path = FileUtils.mkpath bag_it_path
end
