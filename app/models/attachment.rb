class Attachment < ApplicationRecord
  self.table_name = "toap_attachments"
  self.primary_key = "id"

  attr_readonly(*attribute_names)

  # HINT: select * from toap_attachments where ana_id = {toap_publications.element_id}
  #       (toap_publications.element_type = "Container")
  # noinspection RailsParamDefResolve
  belongs_to :analysis, foreign_key: :ana_id, primary_key: :element_id, inverse_of: :attachments

  # noinspection RubyResolve
  def instrument = extended_metadata&.dig("instrument") || ""
end
