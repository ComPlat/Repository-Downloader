class Reaction < Publication
  # HINT: Reaction == `select * from toap_publications where element_type = "Reaction"`
  def self.sti_name = "Reaction"

  def present_to_api = {}

  def chemotion_id = "CRR-#{id}"
end
