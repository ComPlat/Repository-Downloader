describe Sample do
  it_behaves_like "Publication"

  it { expect(described_class.sti_name).to eq "Sample" }
  it { expect { create :sample }.to change(described_class, :count).from(0).to(1) }
  it { expect(create(:sample)).to be_valid }
  it { expect(create(:sample)).to be_persisted }
end
