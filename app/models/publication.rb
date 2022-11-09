class Publication < ApplicationRecord
  attr_readonly(*attribute_names)

  self.inheritance_column = "element_type"
end
