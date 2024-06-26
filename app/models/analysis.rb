class Analysis < Publication
  include Presentable

  # HINT: Analysis == `select * from toap_publications where element_type = "Container"`
  # HINT: belongs to Sample
  def self.sti_name = "Container"

  has_many :attachments, foreign_key: :ana_id, primary_key: :element_id, inverse_of: :analysis, dependent: :restrict_with_exception

  def chemotion_id = id ? "CRD-#{id}" : ""

  def content
    content = extended_metadata&.dig("content")
    content ? JSON.parse(content) : {}
  end

  def doi_uri = doi.present? ? "https://dx.doi.org/#{doi}" : ""

  # HINT: malformed input will result in malformed output
  def ontologies = kind&.split("|")&.last&.strip.to_s

  def doi = taggable_data&.dig("analysis_doi").to_s

  # noinspection RubyResolve
  def kind = extended_metadata&.dig("kind").to_s
end
