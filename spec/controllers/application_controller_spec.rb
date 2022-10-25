describe ApplicationController do
  describe "#new" do
    subject { described_class.new }

    it { is_expected.to be_a described_class }
    it { is_expected.to be_a ActionController::Base }
  end
end
