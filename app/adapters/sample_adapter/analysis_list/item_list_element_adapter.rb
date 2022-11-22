module SampleAdapter
  module AnalysisList
    class ItemListElementAdapter
      def initialize(sample) = @sample = sample

      def itemListElement = @item_list_element ||= item_list_element_array

      private

      def item_list_element_array = @item_list_element_array ||= ItemListElementAdapterIterator.new(@sample).to_a
    end
  end
end
