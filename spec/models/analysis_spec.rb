describe Analysis do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Container" }
  it { expect { create :analysis }.to change(described_class, :count).from(0).to(1) }
  it { expect(create(:analysis)).to be_valid }
  it { expect(create(:analysis)).to be_persisted }

  describe "#chemotion_id" do
    subject(:chemotion_id) { analysis.chemotion_id }

    let(:analysis) { create :analysis, :with_realistic_attributes }

    it { is_expected.to eq "CRD-#{analysis.id}" }
  end
end
