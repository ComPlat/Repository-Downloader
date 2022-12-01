class NewMappersPresenter
  def initialize(publications)
    @publications = publications
  end

  def to_json = @to_json ||= @publications.map { |publication| publication.present_to_api }

  def to_xml = @to_xml ||= @publications.map { |publication| publication.present_to_api }

  private

  def mappers = @mappers ||= @mapper_args.map { |mapper_arg| @mapper_class.from_hash mapper_arg }
end
