module RootAdapters
  class SampleToSampleMapperAdapter
    include Hashable

    def initialize(sample) = (@sample = sample)

    def context = @context ||= "https://schema.org/" # HINT: becomes @context in mapper

    def type = @type ||= "MolecularEntity" # HINT: becomes @type in mapper

    def dct_conformsTo = @dct_conforms_to ||= {"http://purl.org/dc/terms/conformsTo" => dct_element_hash}

    def id = @id ||= @sample.taggable_data&.dig("doi").to_s # HINT: becomes @id in mapper

    def name = @name ||= @sample.iupac_name

    def url = @url ||= "http://chemotion-repository.net/home/publications/molecules/#{@sample.id}" # TODO: Check if this is right

    def identifier = @identifier ||= @sample.chemotion_id

    def iupacName = name

    def smiles = @smiles ||= @sample.cano_smiles

    def inChI = @inchi ||= @sample.inchistring

    def inChIKey = @inchi_key ||= @sample.inchikey

    def molecularFormula = @molecular_formula ||= @sample.sum_formular

    def meltingPoint = @melting_point ||= @sample.sample_melting_point.to_s # TODO: test for e.g. room temperature

    def boilingPoint = @boiling_point ||= @sample.sample_boiling_point.to_s # TODO: test for e.g. room temperature

    def molecularWeight = @molecular_weight ||= {"value" => @sample.molecular_weight}

    def analysisList = @analysis_list ||= SampleAdapter::AnalysisListAdapter.new(@sample).to_h # TODO: move to private method

    private

    def dct_element_hash = {"@id" => SampleAdapter::DctElementAdapter.id, "@type" => SampleAdapter::DctElementAdapter.type}
  end
end
