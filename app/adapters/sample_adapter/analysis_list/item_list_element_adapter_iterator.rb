module SampleAdapter
  module AnalysisList
    class ItemListElementAdapterIterator
      def initialize(sample) = @sample = sample

      def to_a = @to_a ||= [] # TODO: Implement me!
    end
  end
end
