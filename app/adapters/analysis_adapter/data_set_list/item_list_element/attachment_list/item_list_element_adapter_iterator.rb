module AnalysisAdapter::DataSetList::ItemListElement::AttachmentList
  class ItemListElementAdapterIterator
    def initialize(analysis, data_set_attachments)
      @analysis = analysis
      @data_set_attachments = data_set_attachments
    end

    def to_a = @to_a ||= @data_set_attachments.map do |data_set_attachment|
      ItemListElementAdapter.new(@analysis, data_set_attachment).to_h
    end
  end
end
