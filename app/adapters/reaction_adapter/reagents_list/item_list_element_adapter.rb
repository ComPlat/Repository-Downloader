module ReactionAdapter::ReagentsList
  class ItemListElementAdapter
    include Hashable

    def initialize(sample) = @sample = sample

    def type = @type ||= sample_to_sample_mapper_adapter.type.to_s

    def dct_conformsTo = @dct_conforms_to ||= dct_conforms_to_element_adapter.to_h

    def id = @id ||= sample_to_sample_mapper_adapter.id.to_s

    def identifier = @identifier ||= sample_to_sample_mapper_adapter.identifier.to_s

    def name = @name ||= sample_to_sample_mapper_adapter.name.to_s

    def molecularFormula = @molecular_formula ||= sample_to_sample_mapper_adapter.molecularFormula.to_s

    def inChIKey = @inchi_key ||= sample_to_sample_mapper_adapter.inChIKey.to_s

    def smiles = @smiles ||= sample_to_sample_mapper_adapter.smiles.to_s

    private

    def sample_to_sample_mapper_adapter = @sample_to_sample_mapper_adapter ||= RootAdapters::SampleToSampleMapperAdapter.new(@sample)

    def dct_conforms_to_element_adapter = @dct_conforms_to_element_adapter ||= SampleAdapter::DctConformsToElementAdapter.new
  end
end
