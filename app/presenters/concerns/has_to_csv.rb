module HasToCsv
  extend ActiveSupport::Concern

  def to_csv = CsvsStreamable.new(publications)
end
