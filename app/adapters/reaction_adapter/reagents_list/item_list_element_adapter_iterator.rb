module ReactionAdapter::ReagentsList
  class ItemListElementAdapterIterator
    def initialize(reaction) = @reaction = reaction

    def to_a = @to_a ||= @reaction.samples.map { |sample| item_list_element_adapter(sample).to_h }

    private

    def item_list_element_adapter(sample) = ItemListElementAdapter.new(sample)
  end
end
