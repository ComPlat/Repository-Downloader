class Reaction < Publication
  # HINT: Reaction == `select * from toap_publications where element_type = "Reaction"`
  def self.sti_name = "Reaction"

  has_many :samples, foreign_key: :ancestry, inverse_of: :reaction, dependent: :restrict_with_exception

  def chemotion_id = "CRR-#{id}"

  def present_to_api = RootMappers::ReactionMapper.from_hash to_reaction_mapper_hash

  def doi = taggable_data&.dig("doi").to_s

  private

  def to_reaction_mapper_hash = to_reaction_mapper.to_h

  def to_reaction_mapper = RootAdapters::ReactionToReactionMapperAdapter.new self
end
