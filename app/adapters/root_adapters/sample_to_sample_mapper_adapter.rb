module RootAdapters
  class SampleToSampleMapperAdapter
    include Hashable

    def initialize(sample) = @sample = sample

    def context = @context ||= "https://schema.org/" # HINT: becomes @context in mapper

    def type = @type ||= "MolecularEntity" # HINT: becomes @type in mapper

    def dct_conformsTo
      # TODO: Should be dct_conforms_to_adapter, etc.
      @dct_conforms_to ||= dct_conforms_adapter.to_h
    end

    def id = @id ||= @sample.doi # HINT: becomes @id in mapper

    def name = @name ||= @sample.iupac_name

    def url = @url ||= "https://dx.doi.org/#{id}"

    def identifier = @identifier ||= @sample.chemotion_id

    def iupacName = name

    def smiles = @smiles ||= @sample.cano_smiles

    def inChI = @inchi ||= @sample.inchistring

    def inChIKey = @inchi_key ||= @sample.inchikey

    def molecularFormula = @molecular_formula ||= @sample.sum_formular

    def meltingPoint = @melting_point ||= @sample.sample_melting_point.to_s

    def boilingPoint = @boiling_point ||= @sample.sample_boiling_point.to_s

    def molecularWeight = @molecular_weight ||= molecular_weight_adapter.to_h

    def analysisList = @analysis_list ||= analysis_list_adapter.to_h

    private

    def dct_conforms_adapter = @dct_conforms_hash ||= SampleAdapter::DctConformsAdapter.new

    def molecular_weight_adapter = @molecular_weight_hash ||= SampleAdapter::MolecularWeightAdapter.new(@sample)

    def analysis_list_adapter = @analysis_list_hash ||= SampleAdapter::AnalysisListAdapter.new(@sample)
  end
end
