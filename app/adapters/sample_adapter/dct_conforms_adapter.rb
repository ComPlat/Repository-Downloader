module SampleAdapter
  class DctConformsAdapter
    def to_h = @to_h ||= {dct_conformsTo: dct_element_adapter.to_h}

    private

    def dct_element_adapter = @dct_element_hash ||= DctElementAdapter.new
  end
end
