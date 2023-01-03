module SampleAdapter
  class AnalysisListAdapter
    include Hashable

    def initialize(sample) = @sample = sample

    def numberOfItems = analyses.size

    def itemListElement = @item_list_element ||= item_list_element_adapter_iterator.to_a

    private

    def analyses = @analyses ||= @sample.analyses.to_a

    def item_list_element_adapter_iterator = @item_list_element_adapter_iterator ||= SampleAdapter::AnalysisList::ItemListElementAdapterIterator.new(analyses)
  end
end
