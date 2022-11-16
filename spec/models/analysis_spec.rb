describe Analysis do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Container" }
  it { expect { create :analysis }.to change(described_class, :count).from(0).to(1) }
  it { expect(create(:analysis)).to be_valid }
  it { expect(create(:analysis)).to be_persisted }

  describe "associations" do
    it { is_expected.to have_many(:attachments).with_primary_key(:element_id).with_foreign_key(:ana_id).inverse_of(:analysis).dependent(:restrict_with_exception) }
  end

  describe "#attachments" do
    subject { analysis.attachments }

    let(:analysis) { create :analysis, element_id: 1 }
    let(:attachments) { create_list :attachment, 1, ana_id: analysis.element_id, att_id: 2 }

    it { is_expected.to eq attachments }
  end

  describe "#chemotion_id" do
    subject(:chemotion_id) { analysis.chemotion_id }

    let(:analysis) { create :analysis, :with_realistic_attributes }

    it { is_expected.to eq "CRD-#{analysis.id}" }
  end

  describe "#present_to_api" do
    subject(:present_to_api) { analysis.present_to_api }

    let(:analysis) { create :analysis, :with_realistic_attributes }

    it { is_expected.to eq "" }
  end
end
