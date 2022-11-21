module AnalysisAdapter::DataSetList
  class ItemListElementAdapterIterator
    def initialize(analysis) = @analysis = analysis

    def to_a = @to_a ||= attachments_grouped_by_data_set.map do |ds_id, data_set_attachments|
      AnalysisAdapter::DataSetList::ItemListElementAdapter.new(@analysis, ds_id, data_set_attachments).to_h
    end

    private

    def attachments_grouped_by_data_set = @attachments_grouped_by_data_set ||= AttachmentRepository.grouped_by_dataset(@analysis)
  end
end
