module AnalysisAdapter::DataSetList
  class ItemListElementAdapter
    include Hashable

    def initialize(analysis, ds_id, data_set_attachments)
      @analysis = analysis
      @ds_id = ds_id
      @data_set_attachments = data_set_attachments
    end

    def type = @type ||= "DatasetEntity"

    def identifier = @identifier ||= @ds_id

    def name = @name ||= data_set_attachment.name

    def Instrument = @instrument ||= data_set_attachment.instrument

    def descriptions = @descriptions ||= data_set_attachment.ds_desc

    def attachmentList = @attachment_list ||= attachment_list_adapter.to_h

    private

    def attachment_list_adapter = @attachment_list_adapter ||= ItemListElement::AttachmentListAdapter.new(@analysis, @data_set_attachments)

    # HINT: This always works, because this class is only instantiated if data_set_attachments has more than one element.
    def data_set_attachment = @data_set_attachment ||= @data_set_attachments.first
  end
end
