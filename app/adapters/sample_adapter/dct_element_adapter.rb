module SampleAdapter
  class DctElementAdapter
    # TODO: Create specs for me!
    include Hashable

    def initialize(sample) = @sample = sample

    def dctList = @dct_list ||= [] # TODO: Implement me!
  end
end
