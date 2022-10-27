describe ToapPublication do
  describe "columns" do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    # TODO: Add all other columns!
  end

  describe "attr_readonly" do
    let(:attribute_names) { described_class.attribute_names }

    it { attribute_names.each { |attribute_name| is_expected.to have_readonly_attribute attribute_name } }
  end

  describe "#new" do
    subject { described_class.new }

    it { is_expected.to be_a described_class }
  end
end
