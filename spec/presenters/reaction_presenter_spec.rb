describe ReactionPresenter do
  let(:reaction) { build :reaction }
  let(:reaction_presenter) { described_class.new reaction }

  describe ".new" do
    subject(:new) { reaction_presenter }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject { reaction_presenter.to_json }

    it { is_expected.to eq RootMappers::ReactionMapper.from_hash(RootAdapters::ReactionToReactionMapperAdapter.new(reaction).to_h).to_json }
  end

  describe "#to_xml" do
    subject { reaction_presenter.to_xml }

    it { is_expected.to eq RootMappers::ReactionMapper.from_hash(RootAdapters::ReactionToReactionMapperAdapter.new(reaction).to_h).to_xml }
  end

  describe "#to_csv" do
    subject { reaction_presenter.to_csv }

    it { is_expected.to eq RootMappers::ReactionMapper.from_hash(RootAdapters::ReactionToReactionMapperAdapter.new(reaction).to_h).to_csv }
  end

  describe "#to_zip" do
    subject { reaction_presenter.to_zip }

    it { is_expected.to be_nil }
  end
end
