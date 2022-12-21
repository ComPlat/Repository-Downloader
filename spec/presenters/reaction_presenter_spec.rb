describe ReactionPresenter do
  let(:reaction) { create(:reaction, :with_realistic_attributes) }
  let(:reaction_presenter) { described_class.new reaction }

  describe ".new" do
    subject(:new) { reaction_presenter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) { reaction_presenter.to_json }

    it { is_expected.to be_a Enumerator }
    it { expect(to_json.to_a.join).to eq RootMappers::ReactionMapper.from_hash(RootAdapters::ReactionToReactionMapperAdapter.new(reaction).to_h).to_json }
  end

  describe "#to_xml" do
    subject(:to_xml) { reaction_presenter.to_xml }

    it { is_expected.to be_a Enumerator }
    it { expect(to_xml.to_a.join).to eq RootMappers::ReactionMapper.from_hash(RootAdapters::ReactionToReactionMapperAdapter.new(reaction).to_h).to_xml }
  end

  describe "#to_csv" do
    subject(:to_csv) { reaction_presenter.to_csv }

    it { is_expected.to be_a Enumerator }
    it { expect(to_csv.to_a.join).to eq RootMappers::ReactionMapper.from_hash(RootAdapters::ReactionToReactionMapperAdapter.new(reaction).to_h).to_csv }
  end
end
