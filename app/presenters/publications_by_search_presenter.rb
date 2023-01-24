class PublicationsBySearchPresenter
  def initialize(params)
    @params = params
  end

  def publications = @publications ||= PublicationSearchOperation.new(@params).search
end
