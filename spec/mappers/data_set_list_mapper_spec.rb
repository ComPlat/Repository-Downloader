describe DataSetListMapper do
  let(:expected_json_nil_render_value) { "null" }

  describe ".new" do
    context "when called without any arguments" do
      let(:data_set_list_mapper) { build :data_set_list_mapper }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper).to be_a ShaleCustom::Mapper }
      it { expect(data_set_list_mapper.numberOfItems).to be_nil }
      it { expect(data_set_list_mapper.itemListElement).to match_array([]) }
    end

    context "when called with_all_args_nested_structures_as_mappers" do
      let(:args) { attributes_for :data_set_list_mapper, :with_all_args_nested_structures_as_mappers }
      let(:data_set_list_mapper) { described_class.new(**args) }
      let(:data_set_item_list_element_mapper) { data_set_list_mapper.itemListElement }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(data_set_list_mapper.itemListElement).to eq args[:itemListElement] }
    end
  end

  describe ".from_hash" do
    context "when called without any arguments" do
      let(:data_set_list_mapper) { build :data_set_list_mapper }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper.numberOfItems).to be_nil }
      it { expect(data_set_list_mapper.itemListElement).to eq [] }
    end

    context "when called with_all_args_nested_structures_as_hash" do
      let(:args) { attributes_for(:data_set_list_mapper, :with_all_args_nested_structures_as_hash) }
      let(:data_set_list_mapper) { described_class.from_hash args }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(data_set_list_mapper.itemListElement).to all be_a DataSetListItemListElementMapper }
      it { expect(data_set_list_mapper.itemListElement.as_json).to eq args[:itemListElement].as_json }
    end
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:data_set_list_mapper) { build :data_set_list_mapper }

      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems":#{expected_json_nil_render_value},
            "itemListElement":[]
          }
        JSON
      end

      it { expect(JSON.parse(data_set_list_mapper.to_json)).to eq JSON.parse expected_json }
    end

    context "when called with_all_args_nested_structures_as_hash" do
      let(:args) { attributes_for(:data_set_list_mapper, :with_all_args_nested_structures_as_hash) }
      let(:data_set_list_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems":#{args[:numberOfItems]},
            "itemListElement":#{MappersPresenter.new(DataSetListItemListElementMapper, args[:itemListElement]).to_json}
          }
        JSON
      end

      it { expect(JSON.parse(data_set_list_mapper.to_json)).to eq JSON.parse expected_json }
    end
  end
end
