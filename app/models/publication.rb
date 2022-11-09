class Publication < ApplicationRecord
  self.table_name = "toap_publications"
  self.inheritance_column = "element_type"

  attr_readonly(*attribute_names)
end
