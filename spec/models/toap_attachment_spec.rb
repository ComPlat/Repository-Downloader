describe ToapAttachment do
  describe "columns" do
    it { is_expected.to have_db_column(:ana_id).of_type(:integer) }
    it { is_expected.to have_db_column(:ds_id).of_type(:integer) }
    it { is_expected.to have_db_column(:extended_metadata).of_type(:hstore) }
    it { is_expected.to have_db_column(:filename).of_type(:string) }
    it { is_expected.to have_db_column(:identifier).of_type(:uuid) }
    it { is_expected.to have_db_column(:storage).of_type(:string).with_options(limit: 20) }
    it { is_expected.to have_db_column(:content_type).of_type(:string) }
    it { is_expected.to have_db_column(:bucket).of_type(:string) }
    it { is_expected.to have_db_column(:akey).of_type(:string).with_options(limit: 500) }
  end

  describe ".new" do
    subject(:new) { described_class.new }

    it { is_expected.to be_a described_class }
    it { expect { new }.not_to change(described_class, :count) }
    it { is_expected.to be_valid }
    it { is_expected.not_to be_persisted }
  end

  describe ".attr_readonly" do
    subject(:new) { described_class.new }

    let(:attribute_names) { described_class.attribute_names }

    it { attribute_names.each { |attribute_name| expect(new).to have_readonly_attribute attribute_name } }
  end

  describe ".create" do
    subject(:create) { described_class.create }

    it { is_expected.to be_a described_class }
    it { expect { create }.to change(described_class, :count).from(0).to(1) }
    it { is_expected.to be_valid }
    it { is_expected.to be_persisted }
  end
end
