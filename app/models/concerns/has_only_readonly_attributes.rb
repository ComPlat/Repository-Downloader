module HasOnlyReadonlyAttributes
  extend ActiveSupport::Concern

  included do
    attr_readonly(*attribute_names)
  end
end
