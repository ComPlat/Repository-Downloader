class ReactionToReactionMapperAdapter
  def initialize(reaction)
    @reaction = reaction
  end

  def to_h
    (public_methods(false) - [:to_h]).index_with { |method| public_send method }
  end

  def context = "https://schema.org/" # HINT: becomes @context in mapper

  def id = ""

  def type = ""

  def name = ""

  def identifier = @reaction.chemotion_id

  def status = ""

  def description = ""

  def temperature = ""

  def reaction_type = ""

  def duration = ""

  def purification = ""

  def reagents_list = {}
end
