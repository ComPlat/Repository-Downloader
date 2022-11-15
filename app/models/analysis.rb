class Analysis < Publication
  # HINT: Analysis == `select * from toap_publications where element_type = "Container"`
  # HINT: belongs to Sample
  def self.sti_name = "Container"

  has_many :attachments, foreign_key: :ana_id, primary_key: :element_id, inverse_of: :analysis, dependent: :restrict_with_exception

  def present_to_api = AnalysisMapper.new(**AnalysisToAnalysisMapperAdapter.new(self).to_h)

  def chemotion_id = "CRD-#{id}"
end
