module SampleAdapter
  class DctElementAdapter
    # TODO: Create specs for me!
    include Hashable
    def self.id = @id ||= "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE"

    def self.type = @type ||= "CreativeWork"
  end
end
