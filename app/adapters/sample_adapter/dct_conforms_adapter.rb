module SampleAdapter
  class DctConformsAdapter
    CONFORMS_URL = "http://purl.org/dc/terms/conformsTo".freeze

    def to_h = @to_h ||= {CONFORMS_URL => dct_element_hash}

    private

    def dct_element_hash = @dct_element_hash ||= DctElementAdapter.new.to_h
  end
end
