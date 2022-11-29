module HasOnlyReadonlyAttributes
  extend ActiveSupport::Concern

  attr_readonly(*attribute_names)
end
