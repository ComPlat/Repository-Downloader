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

  def ontologies = @analysis.extended_metadata["kind"].split("|").last.strip

  def title = Nokogiri::XML(@analysis.metadata_xml).search("title").map { |title| title.text }.join(";")

  def descriptions = "" # HINT:

  def url = "https://dx.doi.org/#{@analysis.taggable_data["analysis_doi"]}"

  def identifier = @analysis.chemotion_id

  def dataset_list = {numberOfItems:, itemListElement: DataSetListAdapter.new(@analysis).item_list_element}

  private

  def numberOfItems = @analysis.attachments.count
end
