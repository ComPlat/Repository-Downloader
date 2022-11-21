describe SampleAdapter::AnalysisList::ItemListElementAdapter do
  let(:sample) { create :sample, :with_realistic_attributes, taggable_data: {"original_analysis_ids" => [analysis1.id, analysis2.id, analysis3.id]} }
  let(:analysis1) { create :analysis, :with_realistic_attributes, id: 1 }
  let(:analysis2) { create :analysis, :with_realistic_attributes, id: 2 }
  let(:analysis3) { create :analysis, :with_realistic_attributes, id: 3 }
  let(:item_list_element_adapter) { described_class.new sample }

  describe ".new" do
    subject { item_list_element_adapter }

    it { is_expected.to be_a described_class }
  end

  # TODO: Implement me!
  describe "#itemListElement" do
  end
end
