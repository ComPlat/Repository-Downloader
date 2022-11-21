module RootAdapters
  class ReactionToReactionMapperAdapter
    def initialize(reaction)
      @reaction = reaction
    end

    def to_h
      (public_methods(false) - [:to_h]).index_with { |method| public_send method }
    end

    def context = @context ||= "https://schema.org/" # HINT: becomes @context in mapper

    def id = @id ||= @reaction.taggable_data["doi"]

    def type = @type ||= "BioChemicalReaction"

    def name = @name ||= ""

    def identifier = @identifier ||= "CRR-#{@reaction.id}"

    def status = @status ||= @reaction.reaction_status

    def description = @description ||= @reaction.reaction_description

    def temperature = @temperature ||= "#{@reaction.reaction_temperature["userText"]} #{@reaction.reaction_temperature["valueUnit"]}"

    def reaction_type = @reaction_type ||= @reaction.rxno

    def duration = @duration ||= @reaction.reaction_duration

    def purification = @purification ||= @reaction.reaction_purification.first

    def reagents_list = @reagents_list ||= {}
  end
end
