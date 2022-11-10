describe DataSetListMapper do
  let(:expected_json_nil_render_value) { "null" }

  context "when called without any arguments" do
    let(:data_set_list_mapper) { build :data_set_list_mapper }

    it { expect(data_set_list_mapper).to be_a described_class }
    it { expect(data_set_list_mapper).to be_a ShaleCustom::Mapper }
    it { expect(data_set_list_mapper.numberOfItems).to be_nil }
    # it { expect(data_set_list_mapper.datasetList).to be_nil }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems": #{expected_json_nil_render_value}
          }
        JSON
      end

      it {
        expect(data_set_list_mapper.to_json).to eq_without_whitespace expected_json
      }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :data_set_list_mapper, :with_all_args }
      let(:data_set_list_mapper) { described_class.new(**args) }

      it { expect(data_set_list_mapper).to be_a described_class }
      it { expect(data_set_list_mapper.numberOfItems).to eq args[:numberOfItems] }

      describe "#to_json" do
        let(:expected_json) do
          <<~JSON
            { "numberOfItems": #{args[:numberOfItems]} }
          JSON
        end

        it { expect(data_set_list_mapper.to_json).to eq_without_whitespace expected_json }
      end
    end
  end
end
