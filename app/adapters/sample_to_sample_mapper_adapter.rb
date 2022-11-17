class SampleToSampleMapperAdapter
  def initialize(sample)
    @sample = sample
  end

  def to_h
    (public_methods(false) - [:to_h]).index_with { |method| public_send method }
  end

  def context = "https://schema.org/"

  def type = ""

  def dct_ConformsTo = {}

  def id = ""

  def name = ""

  def url = ""

  def identifier = @sample.chemotion_id

  def iupacName = ""

  def smiles = ""

  def inChI = ""

  def inChIKey = ""

  def molecularFormula = ""

  def meltingPoint = ""

  def boilingPoint = ""

  def molecularWeight = ""

  def analysisList = ""
end
