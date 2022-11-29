RSpec.describe "dct_conforms_to_adapter integrates with dct_conforms_to_mapper" do
  subject(:to_json) { dct_conforms_to_mapper.to_json }

  let(:dct_conforms_to_adapter) { SampleAdapter::DctConformsAdapter.new }
  let(:hash) { dct_conforms_to_adapter.to_h }
  let(:dct_conforms_to_mapper) { SampleMappers::DctElementMapper.from_hash hash }

  it {
    expect(JSON.parse(to_json)).to eq({"http://purl.org/dc/terms/conformsTo" =>
                                         {"@id" => "https://bioschemas.org/profiles/MolecularEntity/0.5-RELEASE",
                                          "@type" => "CreativeWork"}})
  }
end
