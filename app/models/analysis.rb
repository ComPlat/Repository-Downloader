class Analysis < Publication
  # HINT: Analysis == `select * from toap_publications where element_type = "Container"`
  # HINT: belongs to Sample
  def self.sti_name = "Container"

  has_many :attachments, foreign_key: :ana_id, primary_key: :element_id, inverse_of: :analysis, dependent: :restrict_with_exception

  def chemotion_id = "CRD-#{id}"

  def present_to_api = RootMappers::AnalysisMapper.from_hash to_analysis_mapper_hash

  private

  def to_analysis_mapper_hash = to_analysis_mapper.to_h

  def to_analysis_mapper = AnalysisToAnalysisMapperAdapter.new self
end
