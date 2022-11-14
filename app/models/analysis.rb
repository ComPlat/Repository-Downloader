class Analysis < Publication
  # HINT: Analysis == `select * from toap_publications where element_type = "Container"`
  def self.sti_name = "Container"

  def present_to_api = @to_api ||= AnalysisMapper.new(**AnalysisToAnalysisMapperAdapter.new(self).to_h)

  def chemotion_id = "CRD-#{id}"
end
