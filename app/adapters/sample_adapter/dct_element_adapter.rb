module SampleAdapter
  class DctElementAdapter
    include Hashable

    ID = "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE".freeze
    TYPE = "CreativeWork".freeze

    def id = ID

    def type = TYPE
  end
end
