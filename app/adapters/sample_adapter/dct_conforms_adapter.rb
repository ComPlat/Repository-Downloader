module SampleAdapter
  class DctConformsAdapter
    def to_h = @to_h ||= {"http://purl.org/dc/terms/conformsTo": dct_element_hash}

    private

    def dct_element_hash = @dct_element_hash ||= DctElementAdapter.new.to_h
  end
end
