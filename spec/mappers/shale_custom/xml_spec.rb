describe ShaleCustom::Xml do
  describe ".new" do
    subject { described_class.new }

    it { is_expected.to be_a described_class }
    it { is_expected.to be_a Shale::Mapping::Xml }
  end

  describe "#map_element" do
    subject(:map_element) { described_class.new.map_element "element", to: :to }

    it { expect(map_element.instance_variable_get(:@render_nil)).to be true }
  end
end
