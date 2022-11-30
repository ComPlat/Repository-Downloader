module AnalysisAdapter::DataSetList::ItemListElement::AttachmentList
  class ItemListElementAdapter
    include Hashable

    def initialize(analysis, data_set_attachment)
      @analysis = analysis
      @data_set_attachment = data_set_attachment
    end

    def type = @type ||= "AttachmentEntity"

    def identifier = @identifier ||= @data_set_attachment.identifier

    def filename = @filename ||= @data_set_attachment.filename

    def filepath = @filepath ||= "data/#{@analysis.chemotion_id}"
  end
end
