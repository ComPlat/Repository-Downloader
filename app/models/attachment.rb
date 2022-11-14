class Attachment < ApplicationRecord
  self.table_name = "toap_attachments"

  attr_readonly(*attribute_names)
end
