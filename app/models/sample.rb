class Sample < Publication
  # HINT: Sample == `select * from toap_publications where element_type = "Sample"`
  def self.sti_name = "Sample"

  def chemotion_id = "CRS-#{id}"

  def present_to_api = SampleMapper.from_hash to_sample_mapper_hash

  private

  def to_sample_mapper_hash = to_sample_mapper.to_h

  def to_sample_mapper = SampleToSampleMapperAdapter.new self
end
