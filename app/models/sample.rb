class Sample < Publication
  include Presentable

  # HINT: Sample == `select * from toap_publications where element_type = "Sample"`
  def self.sti_name = "Sample"

  # HINT: Pseudo has_many, because ids are not in Analysis, but a Hash-nested Array on Sample.
  def analyses = Analysis.where id: analysis_ids

  belongs_to :reaction, foreign_key: :ancestry, inverse_of: :samples

  def chemotion_id = "CRS-#{id}"

  def doi = taggable_data&.dig("doi").to_s

  def url = doi.present? ? "https://dx.doi.org/#{doi}" : ""

  private

  def analysis_ids = taggable_data&.dig("original_analysis_ids") || []
end
