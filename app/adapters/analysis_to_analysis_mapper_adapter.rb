class AnalysisToAnalysisMapperAdapter
  def initialize(analysis)
    @analysis = analysis
  end

  def to_h
    (public_methods(false) - [:to_h]).index_with { |method| public_send method }
  end

  def context = "https://schema.org/" # HINT: becomes @context in mapper

  def type = "AnalysisEntity" # HINT: becomes @type in mapper

  def id = url

  def ontologies = title

  def title = @analysis.extended_metadata["kind"].split("|").last.strip

  def descriptions = @analysis.extended_metadata["content"] # TODO: check if this is right

  def url = "https://dx.doi.org/#{@analysis.taggable_data["analysis_doi"]}"

  def identifier = @analysis.chemotion_id

  def datasetList = {numberOfItems:, itemListElement:}

  private

  def numberOfItems = @analysis.attachments.count

  def itemListElement = data_set_list_adapter.itemListElement

  def data_set_list_adapter = DataSetListItemListElementAdapter.new @analysis
end
