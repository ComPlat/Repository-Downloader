module ReactionAdapter::ReagentsList
  class ItemListElementAdapter
    include Hashable

    def initialize(sample) = @sample = sample

    def type = @type ||= sample_to_sample_mapper_adapter.type

    def dct_conformsTo = @dct_conforms_to ||= dct_conforms_to_element_adapter.to_h

    def id = @id ||= sample_to_sample_mapper_adapter.id

    def identifier = @identifier ||= sample_to_sample_mapper_adapter.identifier

    def name = @name ||= sample_to_sample_mapper_adapter.name

    def molecularFormula = @molecular_formula ||= sample_to_sample_mapper_adapter.molecularFormula

    def inChIKey = @inchi_key ||= sample_to_sample_mapper_adapter.inChIKey

    def smiles = @smiles ||= sample_to_sample_mapper_adapter.smiles

    private

    def sample_to_sample_mapper_adapter = @sample_to_sample_mapper_adapter ||= RootAdapters::SampleToSampleMapperAdapter.new(@sample)

    def dct_conforms_to_element_adapter = @dct_conforms_to_element_adapter ||= SampleAdapter::DctConformsToElementAdapter.new
  end
end
