class AnalysisToAnalysisMapperAdapter
  def initialize(analysis)
    @analysis = analysis
  end

  def to_h = (@to_h ||= (public_methods(false) - [:to_h]).index_with { |method| public_send method })

  def context = (@context ||= "https://schema.org/") # HINT: becomes @context in mapper

  def type = (@type ||= "AnalysisEntity") # HINT: becomes @type in mapper

  def id = (@id ||= "https://dx.doi.org/#{@analysis.taggable_data["analysis_doi"]}")

  def ontologies = (@ontologies ||= @analysis.extended_metadata["kind"].split("|").last.strip)

  def title = ontologies

  def descriptions = (@descriptions ||= @analysis.extended_metadata["content"]) # TODO: check if this is right

  def url = id

  def identifier = (@identifier ||= @analysis.chemotion_id)

  def datasetList = (@datasetList ||= {numberOfItems:, itemListElement:})

  private

  def numberOfItems = @analysis.attachments.count

  def itemListElement = data_set_list_adapter.itemListElement

  def data_set_list_adapter = DataSetListItemListElementAdapter.new @analysis
end
