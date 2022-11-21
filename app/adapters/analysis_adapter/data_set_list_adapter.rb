module AnalysisAdapter
  class DataSetListAdapter
    include Hashable

    def initialize(analysis) = @analysis = analysis

    def numberOfItems = @number_of_items ||= @analysis.attachments.count

    def itemListElement = @item_list_element ||= item_list_element_adapter_iterator.to_a

    private

    def item_list_element_adapter_iterator = @item_list_element_adapter_iterator ||= DataSetList::ItemListElementAdapterIterator.new(@analysis)
  end
end
