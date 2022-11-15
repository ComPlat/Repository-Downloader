class Sample < Publication
  # HINT: Sample == `select * from toap_publications where element_type = "Sample"`
  def self.sti_name = "Sample"
end
