describe AttachmentRepository do
  let(:analysis) { create :analysis, element_id: 1 }
  let(:attachment1_dataset1) { create :attachment, id: 2, ana_id: analysis.element_id, ds_id: 4 }
  let(:attachment1_dataset2) { create :attachment, id: 3, ana_id: analysis.element_id, ds_id: 5 }
  let(:attachment2_dataset2) { create :attachment, id: 6, ana_id: analysis.element_id, ds_id: 5 }

  describe ".grouped_by_dataset" do
    subject(:grouped_by_dataset) { described_class.grouped_by_dataset arg }

    context "when no attachments" do
      let(:arg) { analysis }

      it { is_expected.to eq({}) }
    end

    context "when one attachment for each dataset" do
      before {
        attachment1_dataset1
        attachment1_dataset2
      }

      let(:arg) { analysis }

      it { is_expected.to eq({attachment1_dataset1.ds_id => [attachment1_dataset1], attachment1_dataset2.ds_id => [attachment1_dataset2]}) }
    end

    context "when one attachment for one dataset and two attachments for the other dataset" do
      before {
        attachment1_dataset1
        attachment1_dataset2
        attachment2_dataset2
      }

      let(:arg) { analysis }

      it { is_expected.to eq({attachment1_dataset1.ds_id => [attachment1_dataset1], attachment1_dataset2.ds_id => [attachment1_dataset2, attachment2_dataset2]}) }
    end
  end
end
