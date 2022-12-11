describe PublicationsByChemotionIdPresenter do
  describe ".new" do
    subject(:new) { described_class.new [] }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) { publication_by_chemotion_ids_presenter.to_json }

    let(:publication_by_chemotion_ids_presenter) { described_class.new chemotion_ids }

    context "when chemotion_ids is an empty array" do
      let(:chemotion_ids) { [] }

      it { expect(to_json.to_a.join).to eq "[]" }
    end

    context "when chemotion_ids is an array with one chemotion_id in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:chemotion_ids) { [analysis.id] }

      it { expect(to_json.to_a.join).to eq "[#{analysis.present_to_api.to_json.to_a.join}]" }
    end

    context "when chemotion_ids is an array with two chemotion_id in it" do
      let(:analysis1) { create(:analysis, :with_realistic_attributes) }
      let(:analysis2) { create(:analysis, :with_realistic_attributes) }
      let(:chemotion_ids) { [analysis1.id, analysis2.id] }

      let(:expected_json) do
        "[#{analysis1.present_to_api.to_json.to_a.join},#{analysis2.present_to_api.to_json.to_a.join}]"
      end

      it { expect(to_json.to_a.join).to eq expected_json }
    end
  end

  describe "#to_xml" do
    subject(:to_xml) { publication_by_chemotion_ids_presenter.to_xml }

    let(:publication_by_chemotion_ids_presenter) { described_class.new chemotion_ids }

    context "when chemotion_ids is an empty array" do
      let(:chemotion_ids) { [] }

      it { expect(to_xml.to_a.join).to eq "<publications></publications>" }
    end

    context "when chemotion_ids is an array with one chemotion_id in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:chemotion_ids) { [analysis.id] }

      it { expect(to_xml.to_a.join).to eq "<publications>#{analysis.present_to_api.to_xml.to_a.join}</publications>" }
    end

    context "when chemotion_ids is an array with two chemotion_id in it" do
      let(:analysis1) { create(:analysis, :with_realistic_attributes) }
      let(:analysis2) { create(:analysis, :with_realistic_attributes) }
      let(:chemotion_ids) { [analysis1.id, analysis2.id] }

      let(:expected_xml) do
        ["<publications>",
          analysis1.present_to_api.to_xml.to_a.join,
          analysis2.present_to_api.to_xml.to_a.join,
          "</publications>"].join
      end

      it { expect(to_xml.to_a.join).to eq expected_xml }
    end
  end
end