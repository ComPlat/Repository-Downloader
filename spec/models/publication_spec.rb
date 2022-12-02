describe Publication do
  it_behaves_like "Publication"

  describe ".find_sti_class" do
    it { expect(described_class.find_sti_class("Container")).to eq Analysis }
    it { expect(described_class.find_sti_class("Reaction")).to eq Reaction }
    it { expect(described_class.find_sti_class("Sample")).to eq Sample }
  end
end
