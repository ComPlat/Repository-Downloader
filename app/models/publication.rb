class Publication < ApplicationRecord
  attr_readonly(*attribute_names)
end
