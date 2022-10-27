describe ToapPublication do
  describe "columns" do
    it { is_expected.to have_db_column(:id).of_type(:integer) }
    it { is_expected.to have_readonly_attribute(:id) }
  end

  describe "#new" do
    subject { described_class.new }

    it { is_expected.to be_a described_class }
  end
end
