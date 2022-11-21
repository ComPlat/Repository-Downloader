module SampleAdapter
  class AnalysisListAdapter
    # TODO: Create a spec for me!
    include Hashable

    def initialize(sample) = @sample = sample

    def numberOfItems = 0 # TODO: Implement me!

    def itemListElement = @item_list_element ||= item_list_element_adapter_iterator.to_a

    private

    def item_list_element_adapter_iterator = @item_list_element_adapter_iterator ||= SampleAdapter::AnalysisList::ItemListElementAdapterIterator.new(@sample)
  end
end
