class Publication < ApplicationRecord
  self.table_name = "toap_publications"
  self.inheritance_column = "element_type"

  # HINT: Analysis == `select * from toap_publications where element_type = "Container"`
  def self.find_sti_class(type_name) = type_name == "Container" ? Analysis : super

  attr_readonly(*attribute_names)
end
