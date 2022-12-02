# TODO: Test me!
# TODO: Use me in Sample model.
# TODO: Replicate and test me for Analysis and Reaction.
class SamplePresenter
  def initialize(sample)
    @sample = sample
  end

  def to_json
    @sample.to_json
  end

  def to_xml
    @sample.to_xml
  end

  def to_csv
    @sample.to_csv
  end

  def to_zip
    # TODO: Test and implement me!
    # HINT: Do not put the whole logic in here.
  end
end
