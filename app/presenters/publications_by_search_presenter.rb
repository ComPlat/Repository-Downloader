class PublicationsBySearchPresenter
  def initialize(params)
    @authors = params[:authors]
    @contributor = params[:contributor]
    @description = params[:description]
  end

  def publications = @publications ||= PublicationSearchOperation.new(@authors, @contributor, @description).search
end
