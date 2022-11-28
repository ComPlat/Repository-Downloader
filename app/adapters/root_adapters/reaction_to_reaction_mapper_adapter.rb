module RootAdapters
  class ReactionToReactionMapperAdapter
    include Hashable

    def initialize(reaction) = @reaction = reaction

    def context = @context ||= "https://schema.org/" # HINT: becomes @context in mapper

    def id = @id ||= @reaction.doi # HINT: becomes @id in mapper

    def type = @type ||= "BioChemicalReaction"

    def name = @name ||= "" # HINT: this is a placeholder for later implementation

    def identifier = @identifier ||= @reaction.chemotion_id

    def status = @status ||= @reaction.reaction_status.to_s

    def description = @description ||= @reaction.reaction_description.to_s

    def temperature = @temperature ||= "#{@reaction.temperature_user_text} #{@reaction.temperature_value_unit}"

    def reaction_type = @reaction_type ||= @reaction.rxno.to_s

    def duration = @duration ||= @reaction.reaction_duration.to_s

    def purification = @purification ||= @reaction.reaction_purification.join(", ")

    def reagents_list = @reagents_list ||= reagents_list_adapter.to_h

    private

    def reagents_list_adapter = @reagents_list_adapter ||= ReactionAdapter::ReagentsListAdapter.new(@reaction)
  end
end
