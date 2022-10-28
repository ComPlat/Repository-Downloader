describe ToapPublication do
  describe "columns" do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:taggable_data).of_type(:jsonb) }
    it { is_expected.to have_db_column(:element_type).of_type(:string) }
    it { is_expected.to have_db_column(:element_id).of_type(:integer) }
    it { is_expected.to have_db_column(:ancestry).of_type(:string) }
    it { is_expected.to have_db_column(:metadata_xml).of_type(:text) }
    it { is_expected.to have_db_column(:published_at).of_type(:datetime) }
    it { is_expected.to have_db_column(:doi_suffix).of_type(:string) }
    it { is_expected.to have_db_column(:extended_metadata).of_type(:hstore) }
    it { is_expected.to have_db_column(:reaction_svg_file).of_type(:string) }
    it { is_expected.to have_db_column(:reaction_temperature).of_type(:jsonb) }
    it { is_expected.to have_db_column(:reaction_description).of_type(:text) }
    it { is_expected.to have_db_column(:reaction_observation).of_type(:text) }
    it { is_expected.to have_db_column(:reaction_duration).of_type(:string) }
    it { is_expected.to have_db_column(:reaction_purification).of_type(:string) } # array!
    it { is_expected.to have_db_column(:tlc_solvents).of_type(:string) }
    it { is_expected.to have_db_column(:tlc_description).of_type(:text) }
    it { is_expected.to have_db_column(:reaction_status).of_type(:string) }
    it { is_expected.to have_db_column(:reaction_status).of_type(:string) }
    it { is_expected.to have_db_column(:rinchi_string).of_type(:text) }
    it { is_expected.to have_db_column(:rinchi_long_key).of_type(:text) }
    it { is_expected.to have_db_column(:rinchi_short_key).of_type(:string) }
    it { is_expected.to have_db_column(:rinchi_web_key).of_type(:string) }
    it { is_expected.to have_db_column(:rxno).of_type(:string) }
    it { is_expected.to have_db_column(:sample_svg_file).of_type(:string) }
    it { is_expected.to have_db_column(:molfile).of_type(:binary) }
    it { is_expected.to have_db_column(:sample_desc).of_type(:text) }
    it { is_expected.to have_db_column(:sample_melting_point).of_type(:numrange) }
    it { is_expected.to have_db_column(:sample_boiling_point).of_type(:numrange) }
    it { is_expected.to have_db_column(:target_amount_value).of_type(:float) }
    it { is_expected.to have_db_column(:target_amount_unit).of_type(:string) }
    it { is_expected.to have_db_column(:rs_type).of_type(:string) }
    it { is_expected.to have_db_column(:yield).of_type(:float) }
    it { is_expected.to have_db_column(:iupac_name).of_type(:string) }
    it { is_expected.to have_db_column(:cano_smiles).of_type(:string) }
    it { is_expected.to have_db_column(:sum_formular).of_type(:string) }
    it { is_expected.to have_db_column(:inchikey).of_type(:string) }
    it { is_expected.to have_db_column(:inchistring).of_type(:string) }
    it { is_expected.to have_db_column(:molecular_weight).of_type(:float) }
  end

  describe "#new" do
    subject(:new) { described_class.new }

    it { is_expected.to be_a described_class }
    it { expect { new }.not_to change(described_class, :count) }
    it { is_expected.to be_valid }
    it { is_expected.not_to be_persisted }
  end

  describe "#attr_readonly" do
    subject(:new) { described_class.new }

    let(:attribute_names) { described_class.attribute_names }

    it { attribute_names.each { |attribute_name| expect(new).to have_readonly_attribute attribute_name } }
  end

  describe "#create" do
    subject(:create) { described_class.create }

    it { is_expected.to be_a described_class }
    it { expect { create }.to change(described_class, :count).from(0).to(1) }
    it { is_expected.to be_valid }
    it { is_expected.to be_persisted }
  end
end
