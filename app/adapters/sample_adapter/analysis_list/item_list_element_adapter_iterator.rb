module SampleAdapter
  module AnalysisList
    class ItemListElementAdapterIterator
      def initialize(sample) = @sample = sample

      def to_a = @to_a ||= @sample.analyses.map { |analysis| RootAdapters::AnalysisToAnalysisMapperAdapter.new(analysis).to_h }
    end
  end
end
