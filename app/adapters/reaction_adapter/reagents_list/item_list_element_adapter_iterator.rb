module ReactionAdapter::ReagentsList
  class ItemListElementAdapterIterator
    def initialize(samples) = @samples = samples

    def to_a = @to_a ||= @samples.map { |sample| item_list_element_adapter(sample).to_h }

    private

    def item_list_element_adapter(sample) = ItemListElementAdapter.new(sample)
  end
end
