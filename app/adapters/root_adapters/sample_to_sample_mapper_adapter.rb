module RootAdapters
  class SampleToSampleMapperAdapter
    include Hashable

    def initialize(sample) = (@sample = sample)

    def context = @context ||= "https://schema.org/" # HINT: becomes @context in mapper

    def type = @type ||= "MolecularEntity" # HINT: becomes @type in mapper

    def dct_conformsTo = {} # TODO: Implement me!

    def id = @id ||= @sample.taggable_data["doi"] # HINT: becomes @id in mapper

    def name = iupacName

    def url = @url ||= "http://chemotion-repository.net/home/publications/molecules/#{@sample.id}"

    def identifier = @identifier ||= @sample.chemotion_id

    def iupacName = @iupacName ||= @sample.iupac_name

    def smiles = @smiles ||= @sample.cano_smiles

    def inChI = @inChI ||= @sample.inchistring

    def inChIKey = @inChIKey ||= @sample.inchikey

    def molecularFormula = @molecularFormula ||= @sample.sum_formular

    def meltingPoint = @meltingPoint ||= @sample.sample_melting_point.to_s # TODO: test for e.g. room temperature

    def boilingPoint = @boilingPoint ||= @sample.sample_boiling_point.to_s # TODO: test for e.g. room temperature

    def molecularWeight = @molecularWeight ||= {"value" => @sample.molecular_weight}

    def analysisList = @analysisList ||= {numberOfItems:, itemListElement:}

    private

    def numberOfItems = 0

    def itemListElement
      # TODO: Implement me!
    end

    def analysis_list_adapter = AnalysisListItemListElementAdapter.new @sample
  end
end
