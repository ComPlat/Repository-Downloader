describe Reaction do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Reaction" }
  it { expect { create :reaction }.to change(described_class, :count).from(0).to(1) }
  it { expect(create(:reaction)).to be_valid }
  it { expect(create(:reaction)).to be_persisted }

  describe "#present_to_api" do
    subject(:present_to_api) { reaction.present_to_api }

    let(:reaction) { create :reaction, :with_realistic_attributes }

    it { is_expected.to eq({}) }
  end

  describe "#chemotion_id" do
    subject(:chemotion_id) { reaction.chemotion_id }

    let(:reaction) { create :reaction, :with_realistic_attributes }

    it { is_expected.to eq "CRR-#{reaction.id}" }
  end
end
