module SampleAdapter
  class AnalysisListAdapter
    include Hashable

    def initialize(sample) = @sample = sample

    def numberOfItems = @sample.analyses.size

    def itemListElement = @item_list_element ||= item_list_element_adapter_iterator.to_a

    private

    def item_list_element_adapter_iterator = @item_list_element_adapter_iterator ||= SampleAdapter::AnalysisList::ItemListElementAdapterIterator.new(@sample)
  end
end
