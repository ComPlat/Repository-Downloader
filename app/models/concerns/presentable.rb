module Presentable
  extend ActiveSupport::Concern

  def present_to_api = Object.const_get("#{self.class.name}Presenter").new self # HINT: e.g. SamplePresenter
end
