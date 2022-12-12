class Publication < ApplicationRecord
  self.table_name = "toap_publications"
  self.inheritance_column = "element_type"

  include HasOnlyReadonlyAttributes

  # HINT: Analysis == `select * from toap_publications where element_type = "Container"`
  def self.find_sti_class(type_name) = (type_name == "Container") ? Analysis : super(type_name)
end
