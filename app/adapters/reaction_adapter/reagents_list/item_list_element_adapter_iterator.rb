module ReactionAdapter::ReagentsList
  class ItemListElementAdapterIterator
    def initialize(reaction) = @reaction = reaction

    def to_a = @to_a ||= @reaction.samples.map { |sample| ItemListElementAdapter.new(sample).to_h }
  end
end
