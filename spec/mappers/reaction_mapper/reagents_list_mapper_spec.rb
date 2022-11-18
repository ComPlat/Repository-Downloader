describe ReactionMappers::ReagentsListMapper do
  let(:expected_json_nil_render_value) { "null" }

  context "when called without any arguments" do
    let(:reagents_list_mapper) { build :reagents_list_mapper }

    it { expect(reagents_list_mapper).to be_a described_class }
    it { expect(reagents_list_mapper).to be_a ShaleCustom::Mapper }
    it { expect(reagents_list_mapper.numberOfItems).to be_nil }
    it { expect(reagents_list_mapper.itemListElement).to match_array([]) }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems": #{expected_json_nil_render_value},
            "itemListElement":[]
          }
        JSON
      end

      it { expect(reagents_list_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  context "when called with all arguments" do
    let(:args) { attributes_for :reagents_list_mapper, :with_all_args }
    let(:reagents_list_mapper) { described_class.new(**args) }
    let(:reagents_list_item_list_element_mapper) { build :reagents_list_item_list_element_mapper, :with_all_args }

    it { expect(reagents_list_mapper).to be_a described_class }
    it { expect(reagents_list_mapper.numberOfItems).to eq args[:numberOfItems] }
    it { expect(reagents_list_mapper.itemListElement).to eq args[:itemListElement] }
    it { expect(reagents_list_mapper.itemListElement.to_json).to eq_without_whitespace reagents_list_item_list_element_mapper.to_json }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems":#{args[:numberOfItems]},
            "itemListElement":[#{reagents_list_item_list_element_mapper.to_json}]
          }
        JSON
      end

      it { expect(reagents_list_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
