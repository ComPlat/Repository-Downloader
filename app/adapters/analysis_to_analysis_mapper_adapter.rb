class AnalysisToAnalysisMapperAdapter
  def initialize(analysis)
    @analysis = analysis
  end

  def to_h
    (public_methods(false) - [:to_h]).index_with { |method| public_send method }
  end

  def context = "https://schema.org/"

  def type = "AnalysisEntity"

  def id = ""

  def ontologies = ""

  def title = ""

  def descriptions = ""

  def url = ""

  def identifier = ""

  def datasetList = {}
end
