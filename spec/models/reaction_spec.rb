describe Reaction do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Reaction" }
  it { expect { create :reaction }.to change(described_class, :count).from(0).to(1) }
  it { expect(create(:reaction)).to be_valid }
  it { expect(create(:reaction)).to be_persisted }
end
