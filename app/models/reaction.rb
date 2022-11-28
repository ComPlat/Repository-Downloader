class Reaction < Publication
  include Presentable

  # HINT: Reaction == `select * from toap_publications where element_type = "Reaction"`
  def self.sti_name = "Reaction"

  has_many :samples, foreign_key: :ancestry, inverse_of: :reaction, dependent: :restrict_with_exception

  def chemotion_id = "CRR-#{id}"

  def doi = taggable_data&.dig("doi").to_s

  def temperature_user_text = reaction_temperature&.dig("userText").to_s

  def temperature_value_unit = reaction_temperature&.dig("valueUnit").to_s
end
