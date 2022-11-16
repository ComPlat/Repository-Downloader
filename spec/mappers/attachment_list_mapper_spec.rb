describe AttachmentListMapper do
  let(:expected_json_nil_render_value) { "null" }

  context "when called without any arguments" do
    let(:attachment_list_mapper) { build :attachment_list_mapper }

    it { expect(attachment_list_mapper).to be_a described_class }
    it { expect(attachment_list_mapper).to be_a ShaleCustom::Mapper }
    it { expect(attachment_list_mapper.numberOfItems).to be_nil }
    it { expect(attachment_list_mapper.itemListElement).to match_array([]) }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems": #{expected_json_nil_render_value},
            "itemListElement":[]
          }
        JSON
      end

      it { expect(attachment_list_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  context "when called with all arguments" do
    let(:item_list_element_args) {
      [attributes_for(:attachment_list_item_list_element_mapper, :with_all_args),
        attributes_for(:attachment_list_item_list_element_mapper, :with_all_args, filename: "HRMS.jpg")]
    }
    let(:args) {
      attributes_for :attachment_list_mapper, :with_all_args,
        itemListElement: item_list_element_args.map { |args| AttachmentListItemListElementMapper.new(**args) }
    }
    let(:attachment_list_mapper) { described_class.new(**args) }

    it { expect(attachment_list_mapper).to be_a described_class }
    it { expect(attachment_list_mapper.numberOfItems).to eq args[:numberOfItems] }
    it { expect(attachment_list_mapper.itemListElement).to eq args[:itemListElement] }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          { "numberOfItems":#{args[:numberOfItems]},
            "itemListElement": #{MappersPresenter.new(AttachmentListItemListElementMapper, item_list_element_args).to_json} }
        JSON
      end

      it { expect(attachment_list_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
