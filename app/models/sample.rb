class Sample < Publication
  # HINT: Sample == `select * from toap_publications where element_type = "Sample"`
  def self.sti_name = "Sample"

  def chemotion_id = "CRS-#{id}"

  def present_to_api = SampleMapper.from_hash to_reaction_mapper_hash

  private

  def to_reaction_mapper_hash = to_reaction_mapper.to_h

  def to_reaction_mapper = SampleToSampleMapperAdapter.new self
end
