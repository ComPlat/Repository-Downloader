module AnalysisAdapter::DataSetList::ItemListElement::AttachmentList
  class ItemListElementAdapter
    include Hashable

    def initialize(analysis, ds_id, attachment_list_attachments)
      @analysis = analysis
      @ds_id = ds_id
      @attachment_list_attachments = attachment_list_attachments
    end

    def type = @type ||= "AttachmentEntity"

    def identifier = @identifier ||= attachment_list_attachment.identifier

    def filename = @filename ||= attachment_list_attachment.filename

    def filepath = @filepath ||= "data/#{@analysis.chemotion_id}"

    private

    # HINT: This always works, because this class is only instantiated if attachment_list_attachments has more than one element.
    def attachment_list_attachment = @attachment_list_attachment ||= @attachment_list_attachments.first
  end
end
