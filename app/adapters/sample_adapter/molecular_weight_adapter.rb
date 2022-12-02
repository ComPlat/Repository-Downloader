module SampleAdapter
  class MolecularWeightAdapter
    include Hashable

    def initialize(sample) = @sample = sample

    def value = @value ||= @sample.molecular_weight
  end
end
