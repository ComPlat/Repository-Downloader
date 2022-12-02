module AnalysisAdapter::DataSetList::ItemListElement
  class AttachmentListAdapter
    include Hashable

    def initialize(analysis, data_set_attachments)
      @analysis = analysis
      @data_set_attachments = data_set_attachments
    end

    def numberOfItems = @number_of_items ||= @data_set_attachments.size

    def itemListElement = @item_list_element ||= item_list_element_adapter_iterator.to_a

    private

    def item_list_element_adapter_iterator = @item_list_element_adapter_iterator ||= AttachmentList::ItemListElementAdapterIterator.new(@analysis, @data_set_attachments)
  end
end
