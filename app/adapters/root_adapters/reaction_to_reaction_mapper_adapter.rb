module RootAdapters
  class ReactionToReactionMapperAdapter
    include Hashable

    def initialize(reaction) = @reaction = reaction

    def context = @context ||= "https://schema.org/" # HINT: becomes @context in mapper

    def id = @id ||= @reaction.taggable_data&.dig("doi").to_s # TODO: check if this is correct

    def type = @type ||= "BioChemicalReaction"

    def name = @name ||= "" # TODO: implement me!

    def identifier = @identifier ||= "CRR-#{@reaction.id}"

    def status = @status ||= @reaction.reaction_status.to_s

    def description = @description ||= @reaction.reaction_description.to_s

    def temperature = @temperature ||= "#{@reaction.reaction_temperature["userText"]} #{@reaction.reaction_temperature["valueUnit"]}"

    def reaction_type = @reaction_type ||= @reaction.rxno.to_s

    def duration = @duration ||= @reaction.reaction_duration.to_s

    def purification = @purification ||= @reaction.reaction_purification.first.to_s

    def reagents_list = @reagents_list ||= {} # TODO: implement ReactionAdapter::ReagentsListAdapter
  end
end
