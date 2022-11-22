module RootAdapters
  class AnalysisToAnalysisMapperAdapter
    include Hashable

    def initialize(analysis) = @analysis = analysis

    def context = @context ||= "https://schema.org/" # HINT: becomes @context in mapper

    def type = @type ||= "AnalysisEntity" # HINT: becomes @type in mapper

    def id = @id ||= "https://dx.doi.org/#{@analysis.taggable_data["analysis_doi"]}"

    def ontologies = @ontologies ||= @analysis.extended_metadata["kind"].split("|").last.strip

    def title = ontologies

    def descriptions = @descriptions ||= @analysis.extended_metadata["content"] # TODO: check if this is right

    def url = id

    def identifier = @identifier ||= @analysis.chemotion_id

    def datasetList = @data_set_list ||= data_set_list_adapter.to_h

    private

    def data_set_list_adapter = @data_set_list_adapter ||= AnalysisAdapter::DataSetListAdapter.new(@analysis)
  end
end
