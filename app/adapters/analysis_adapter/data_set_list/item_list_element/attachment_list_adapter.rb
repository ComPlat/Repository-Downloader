module AnalysisAdapter::DataSetList::ItemListElement
  class AttachmentListAdapter
    include Hashable

    def initialize(analysis, attachments)
      @analysis = analysis
      @attachments = attachments
    end

    def numberOfItems = @number_of_items ||= @attachments.count

    def itemListElement = @item_list_element ||= item_list_element_adapter_iterator.to_a

    private

    def item_list_element_adapter_iterator = @item_list_element_adapter_iterator ||= AttachmentList::ItemListElementAdapterIterator.new(@analysis)
  end
end
