class Reaction < Publication
  # HINT: Reaction == `select * from toap_publications where element_type = "Reaction"`
  def self.sti_name = "Reaction"

  def present_to_api = @to_api ||= ReactionMapper.new(**ReactionToReactionMapperAdapter.new(self).to_h)

  def chemotion_id = "CRR-#{id}"
end
