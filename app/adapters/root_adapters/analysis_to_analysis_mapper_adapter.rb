module RootAdapters
  class AnalysisToAnalysisMapperAdapter
    include Hashable

    def initialize(analysis) = @analysis = analysis

    def context = @context ||= "https://schema.org/" # HINT: becomes @context in mapper

    def type = @type ||= "AnalysisEntity" # HINT: becomes @type in mapper

    def id = @id ||= "https://dx.doi.org/#{@analysis.taggable_data&.dig("analysis_doi")}"

    def ontologies = @ontologies ||= @analysis.extended_metadata&.dig("kind")&.split("|")&.last&.strip.to_s

    def title = ontologies

    def descriptions = @descriptions ||= @analysis.extended_metadata&.dig("content").to_s

    def url = id

    def identifier = @identifier ||= @analysis.chemotion_id

    def datasetList = @data_set_list ||= data_set_list_adapter.to_h

    private

    def data_set_list_adapter = @data_set_list_adapter ||= AnalysisAdapter::DataSetListAdapter.new(@analysis)
  end
end
