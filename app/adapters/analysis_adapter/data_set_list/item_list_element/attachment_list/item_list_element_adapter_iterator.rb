module AnalysisAdapter::DataSetList::ItemListElement::AttachmentList
  class ItemListElementAdapterIterator
    def initialize(analysis) = @analysis = analysis

    def to_a = @to_a ||= attachments_grouped_by_datastore.map do |ds_id, attachments|
      AnalysisAdapter::DataSetList::ItemListElement::AttachmentList::ItemListElementAdapter.new(@analysis, ds_id, attachments).to_h
    end

    private

    def attachments_grouped_by_datastore = @attachments_grouped_by_datastore ||= AttachmentRepository.grouped_by_dataset(@analysis)
  end
end
