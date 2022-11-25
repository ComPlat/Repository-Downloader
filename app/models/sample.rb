class Sample < Publication
  # HINT: Sample == `select * from toap_publications where element_type = "Sample"`
  def self.sti_name = "Sample"

  # HINT: Pseudo has_many, because ids are not in Analysis, but a Hash-nested Array on Sample.
  def analyses = Analysis.where id: analysis_ids

  belongs_to :reaction, foreign_key: :ancestry, inverse_of: :samples

  def chemotion_id = "CRS-#{id}"

  def present_to_api = RootMappers::SampleMapper.from_hash to_sample_mapper_hash

  private

  def to_sample_mapper_hash = to_sample_mapper.to_h

  def to_sample_mapper = RootAdapters::SampleToSampleMapperAdapter.new self

  def analysis_ids = taggable_data&.dig("original_analysis_ids") || []
end
