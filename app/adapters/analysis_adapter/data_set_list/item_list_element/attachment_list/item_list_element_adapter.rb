module AnalysisAdapter::DataSetList::ItemListElement::AttachmentList
  class ItemListElementAdapter
    include Hashable

    def initialize(analysis, ds_id, attachments)
      @analysis = analysis
      @ds_id = ds_id
      @attachments = attachments
    end

    def type = @type ||= "AttachmentEntity"

    def identifier = @identifier ||= @attachments.first.identifier # TODO: Check if correct.

    def filename = @filename ||= @attachments.first.filename

    def filepath = @filepath ||= "data/#{@analysis.chemotion_id}"
  end
end
