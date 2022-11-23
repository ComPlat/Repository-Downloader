module SampleAdapter::AnalysisList
  class ItemListElementAdapter
    def initialize(sample) = @sample = sample

    def itemListElement = @item_list_element ||= item_list_element.to_a

    private

    def item_list_element = @item_list_element ||= ItemListElementAdapterIterator.new(@sample)
  end
end
