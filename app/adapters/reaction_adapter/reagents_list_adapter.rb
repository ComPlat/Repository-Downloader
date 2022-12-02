module ReactionAdapter
  class ReagentsListAdapter
    include Hashable

    def initialize(reaction) = @reaction = reaction

    def numberOfItems = @number_of_items ||= reaction_samples.size

    def itemListElement = @item_list_element ||= item_list_element_adapter_iterator.to_a

    private

    def reaction_samples = @reaction_samples ||= @reaction.samples

    def item_list_element_adapter_iterator = @item_list_element_adapter_iterator ||= ReagentsList::ItemListElementAdapterIterator.new(reaction_samples)
  end
end
