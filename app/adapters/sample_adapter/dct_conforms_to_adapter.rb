module SampleAdapter
  class DctConformsToAdapter
    def to_h = @to_h ||= {dct_conformsTo: dct_element_adapter.to_h}

    private

    def dct_element_adapter = @dct_element_hash ||= DctConformsToElementAdapter.new
  end
end
