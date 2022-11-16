describe AttachmentListMapper do
  let(:expected_json_nil_render_value) { "null" }

  describe ".new" do
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
      let(:args) { attributes_for :attachment_list_mapper, :with_all_args_nested_structures_as_mappers }
      let(:attachment_list_mapper) { described_class.new(**args) }

      it { expect(attachment_list_mapper).to be_a described_class }
      it { expect(attachment_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(attachment_list_mapper.itemListElement).to eq args[:itemListElement] }
    end
  end

  describe ".from_hash" do
    let(:args) { attributes_for(:attachment_list_mapper, :with_all_args_nested_structures_as_hash) }
    let(:attachment_list_mapper) { described_class.from_hash args.deep_stringify_keys }

    it { expect(attachment_list_mapper).to be_a described_class }
    it { expect(attachment_list_mapper.numberOfItems).to eq args[:numberOfItems] }
    it { expect(attachment_list_mapper.itemListElement).to all be_a AttachmentListItemListElementMapper }
    it { expect(attachment_list_mapper.itemListElement.as_json).to eq args[:itemListElement].as_json }
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:attachment_list_mapper) { build :attachment_list_mapper }

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

    context "when called with all arguments" do
      let(:args) { attributes_for(:attachment_list_mapper, :with_all_args_nested_structures_as_hash) }
      let(:attachment_list_mapper) { described_class.from_hash args.deep_stringify_keys }

      let(:expected_json) do
        <<~JSON
          { "numberOfItems":#{args[:numberOfItems]},
            "itemListElement": #{MappersPresenter.new(AttachmentListItemListElementMapper, args[:itemListElement]).to_json} }
        JSON
      end

      it { expect(attachment_list_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
