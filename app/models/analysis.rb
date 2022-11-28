class Analysis < Publication
  include Presentable

  # HINT: Analysis == `select * from toap_publications where element_type = "Container"`
  # HINT: belongs to Sample
  def self.sti_name = "Container"

  has_many :attachments, foreign_key: :ana_id, primary_key: :element_id, inverse_of: :analysis, dependent: :restrict_with_exception

  def chemotion_id = "CRD-#{id}"

  def doi = taggable_data&.dig("analysis_doi")

  # noinspection RubyResolve
  def kind = extended_metadata&.dig("kind")
end
