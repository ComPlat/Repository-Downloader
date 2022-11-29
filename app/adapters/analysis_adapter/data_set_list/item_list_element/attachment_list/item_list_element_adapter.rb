module AnalysisAdapter::DataSetList::ItemListElement::AttachmentList
  class ItemListElementAdapter
    include Hashable

    def initialize(analysis, attachment_list_attachment)
      @analysis = analysis
      @attachment_list_attachment = attachment_list_attachment
    end

    def type = @type ||= "AttachmentEntity"

    def identifier = @identifier ||= @attachment_list_attachment.identifier

    def filename = @filename ||= @attachment_list_attachment.filename

    def filepath = @filepath ||= "data/#{@analysis.chemotion_id}"
  end
end
