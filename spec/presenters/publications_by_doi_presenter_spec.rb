describe PublicationsByDoiPresenter do
  describe ".new" do
    subject(:new) { described_class.new [] }

    it { is_expected.to be_a described_class }
  end

  describe "#to_json" do
    subject(:to_json) { publication_by_doi_presenter.to_json }

    let(:publication_by_doi_presenter) { described_class.new dois }

    context "when dois is an empty array" do
      let(:dois) { [] }

      it { expect(to_json.to_a.join).to eq "[]" }
    end

    context "when dois is an array with one doi in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:dois) { [analysis.doi] }

      it { expect(to_json.to_a.join).to eq "[#{analysis.present_to_api.to_json.to_a.join}]" }
    end

    context "when dois is an array with two doi in it" do
      let(:analysis1) { create(:analysis, :with_realistic_attributes) }
      let(:analysis2) do
        create(:analysis, :with_realistic_attributes, taggable_data: {"doi" => analysis1.doi.tr("N", "X"),
                                                                      "analysis_doi" => analysis1.doi.tr("N", "X")})
      end
      let(:dois) { [analysis1.doi, analysis2.doi] }

      let(:expected_json) do
        "[#{analysis1.present_to_api.to_json.to_a.join},#{analysis2.present_to_api.to_json.to_a.join}]"
      end

      it { expect(to_json.to_a.join).to eq expected_json }
    end
  end

  describe "#to_xml" do
    subject(:to_xml) { publication_by_doi_presenter.to_xml }

    let(:publication_by_doi_presenter) { described_class.new dois }

    context "when dois is an empty array" do
      let(:dois) { [] }

      it { expect(to_xml.to_a.join).to eq "<publications></publications>" }
    end

    context "when dois is an array with one doi in it" do
      let(:analysis) { create(:analysis, :with_realistic_attributes) }
      let(:dois) { [analysis.doi] }

      it { expect(to_xml.to_a.join).to eq "<publications>#{analysis.present_to_api.to_xml.to_a.join}</publications>" }
    end

    context "when dois is an array with two doi in it" do
      let(:analysis1) { create(:analysis, :with_realistic_attributes) }
      let(:analysis2) do
        create(:analysis, :with_realistic_attributes, taggable_data: {"doi" => analysis1.doi.tr("N", "A"),
                                                                      "analysis_doi" => analysis1.doi.tr("N", "A")})
      end
      let(:dois) { [analysis1.doi, analysis2.doi] }

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
