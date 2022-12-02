module Hashable
  extend ActiveSupport::Concern

  def to_h = @to_h ||= (public_methods(false) - [:to_h]).index_with { |method| public_send method }
end
