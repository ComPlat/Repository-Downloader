class DataSetListItemListElementAdapter
  def initialize(analysis)
    @analysis = analysis
  end

  # TODO: this needs to return a hash
  def itemListElement = # noinspection RubyResolve
    attachments_grouped_by_datastore.map do |ds_id, attachments|
      {type: "DatasetEntity",
       identifier: ds_id, # TODO: Find out where this comes from database.
       name: "BJ68_1H", # TODO: Find out where this comes from database.
       Instrument: attachments.first.extended_metadata.dig("instrument"),
       descriptions: "", # TODO: Find out where this comes from database.
       attachmentList: attachment_list(attachments)} # TODO: this needs to be an AttachmentListMapper
    end

  private

  def attachment_list(attachments) = {numberOfItems: attachments.count, itemListElement: attachment_list_item_list_element(attachments)}

  def attachment_list_item_list_element(attachments) = attachments.map do |attachment|
    {type: "AttachmentEntity",
     identifier: attachment.identifier, # TODO: Check if correct.
     filename: attachment.filename,
     filepath: "data/#{@analysis.chemotion_id}"} # TODO: Check if correct. }
  end

  def attachments_grouped_by_datastore = AttachmentRepository.grouped_by_dataset(@analysis)
end
