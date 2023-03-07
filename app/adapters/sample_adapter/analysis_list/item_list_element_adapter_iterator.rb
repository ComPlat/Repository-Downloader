module SampleAdapter
  module AnalysisList
    class ItemListElementAdapterIterator
      def initialize(analyses) = @analyses = analyses

      def to_a = @to_a ||= @analyses.map { |analysis| RootAdapters::AnalysisToAnalysisMapperAdapter.new(analysis).to_h }
    end
  end
end
