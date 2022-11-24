describe Attachment do
  describe "columns" do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_db_column(:name).of_type(:string) }
    it { is_expected.to have_db_column(:ds_desc).of_type(:string) }
    it { is_expected.to have_db_column(:filesize).of_type(:string) }
    it { is_expected.to have_db_column(:att_id).of_type(:integer) }
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

  describe "factories" do
    describe "with traits :with_required_dependencies" do
      subject(:factory) { build :attachment, :with_required_dependencies }

      it { is_expected.to be_valid }
      it { expect(factory.save).to be true }
    end

    describe "without trait" do
      subject(:factory) { build :attachment }

      it { is_expected.to be_invalid }
      it { expect(factory.save).to be false }
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:analysis).with_primary_key(:element_id).with_foreign_key(:ana_id).inverse_of(:attachments) }

    describe "#analysis" do
      let(:analysis) { create :analysis }
      let(:attachment) { create :attachment, analysis: }

      it { expect(attachment.analysis).to eq analysis }
      it { expect { create :attachment }.to raise_error ActiveRecord::RecordInvalid, "Validation failed: Analysis must exist" }
    end
  end

  describe ".new" do
    subject(:new) { described_class.new }

    it { is_expected.to be_a described_class }
    it { expect { new }.not_to change described_class, :count }
    it { is_expected.not_to be_persisted }
  end

  describe ".create" do
    subject(:create_method) { described_class.create }

    it { is_expected.to be_a described_class }
  end

  describe ".attr_readonly" do
    subject(:new) { described_class.new }

    let(:attribute_names) { described_class.attribute_names }

    it { attribute_names.each { |attribute_name| expect(new).to have_readonly_attribute attribute_name } }
  end

  describe "#instrument" do
    subject(:instrument) { attachment.instrument }

    context "when extended_metadata is nil" do
      let(:attachment) { build :attachment, extended_metadata: nil }

      it { is_expected.to eq "" }
    end

    context "when extended_metadata is a Hash and has nil on key instrument" do
      let(:attachment) { build :attachment, extended_metadata: {"instrument" => nil} }

      it { is_expected.to eq "" }
    end

    context "when extended_metadata is a Hash and has a string" do
      let(:attachment) { build :attachment, extended_metadata: {"instrument" => "some instrument"} }

      it { is_expected.to eq attachment.extended_metadata["instrument"] }
    end
  end
end
