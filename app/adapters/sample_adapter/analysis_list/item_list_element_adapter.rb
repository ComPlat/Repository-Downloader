module SampleAdapter
  module AnalysisList
    class ItemListElementAdapter
      def initialize(sample) = @sample = sample

      def itemListElement = @item_list_element ||= [] # TODO: Implement me!
    end
  end
end
