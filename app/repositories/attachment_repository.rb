class AttachmentRepository
  def self.grouped_by_dataset(analysis) = analysis.attachments.group_by { |attachment| attachment.ds_id }
end
