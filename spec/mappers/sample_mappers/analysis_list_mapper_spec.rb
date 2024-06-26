describe SampleMappers::AnalysisListMapper do
  let(:expected_json_nil_render_value) { "null" }

  describe "factories" do
    describe "trait :with_all_args_nested_structures_as_mappers" do
      subject(:factory) { build(:analysis_list_mapper, :with_all_args_nested_structures_as_mappers) }

      it { expect(factory.instance_variable_get(:@itemListElement).size).to eq 1 }
      it { expect(factory.instance_variable_get(:@itemListElement).size).to eq factory.instance_variable_get :@numberOfItems }
      it { expect(factory.instance_variable_get(:@itemListElement)).to all be_a RootMappers::AnalysisMapper }
    end

    describe "trait :with_all_args_nested_structures_as_hash" do
      subject(:factory) { build(:analysis_list_mapper, :with_all_args_nested_structures_as_hash) }

      it { expect(factory.instance_variable_get(:@itemListElement).size).to eq 1 }
      it { expect(factory.instance_variable_get(:@itemListElement).size).to eq factory.instance_variable_get :@numberOfItems }
      it { expect(factory.instance_variable_get(:@itemListElement)).to all be_a Hash }
    end
  end

  describe ".new" do
    context "when called without any arguments" do
      let(:analysis_list_mapper) { build(:analysis_list_mapper) }

      it { expect(analysis_list_mapper).to be_a described_class }
      it { expect(analysis_list_mapper).to be_a ShaleCustom::Mapper }
      it { expect(analysis_list_mapper.numberOfItems).to be_nil }
      it { expect(analysis_list_mapper.itemListElement).to match_array([]) }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:analysis_list_mapper, :with_all_args_nested_structures_as_mappers) }
      let(:analysis_list_mapper) { described_class.new(**args) }

      it { expect(analysis_list_mapper).to be_a described_class }
      it { expect(analysis_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(analysis_list_mapper.itemListElement).to eq args[:itemListElement] }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:analysis_list_mapper, :with_all_args_nested_structures_as_mappers, numberOfItems: nil) }
      let(:analysis_list_mapper) { described_class.new(**args) }

      it { expect(analysis_list_mapper).to be_a described_class }
      it { expect(analysis_list_mapper.numberOfItems).to be_nil }
      it { expect(analysis_list_mapper.itemListElement).to eq args[:itemListElement] }
    end
  end

  describe ".from_hash" do
    context "when called without any arguments" do
      let(:analysis_list_mapper) { build(:analysis_list_mapper) }

      it { expect(analysis_list_mapper).to be_a described_class }
      it { expect(analysis_list_mapper.numberOfItems).to be_nil }
      it { expect(analysis_list_mapper.itemListElement).to eq [] }
    end

    context "when called with_all_args_nested_structures_as_hash" do
      let(:args) { attributes_for(:analysis_list_mapper, :with_all_args_nested_structures_as_hash) }
      let(:analysis_list_mapper) { described_class.from_hash args }

      it { expect(analysis_list_mapper).to be_a described_class }
      it { expect(analysis_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(analysis_list_mapper.itemListElement).to all be_a RootMappers::AnalysisMapper }
      it { expect(analysis_list_mapper.itemListElement.as_json).to eq args[:itemListElement].as_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:analysis_list_mapper, :with_all_args_nested_structures_as_hash, numberOfItems: nil) }
      let(:analysis_list_mapper) { described_class.from_hash args }

      it { expect(analysis_list_mapper).to be_a described_class }
      it { expect(analysis_list_mapper.numberOfItems).to be_nil }
      it { expect(analysis_list_mapper.itemListElement.as_json).to eq args[:itemListElement].as_json }
    end
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:analysis_list_mapper) { build(:analysis_list_mapper) }

      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems":#{expected_json_nil_render_value},
            "itemListElement":[]
          }
        JSON
      end

      it { expect(JSON.parse(analysis_list_mapper.to_json)).to eq JSON.parse expected_json }
    end

    context "when called with_all_args_nested_structures_as_hash" do
      let(:args) { attributes_for(:analysis_list_mapper, :with_all_args_nested_structures_as_hash) }
      let(:analysis_list_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems":#{args[:numberOfItems]},
            "itemListElement":#{MappersPresenter.new(RootMappers::AnalysisMapper, args[:itemListElement]).to_json}
          }
        JSON
      end

      it { expect(JSON.parse(analysis_list_mapper.to_json)).to eq JSON.parse expected_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:analysis_list_mapper, :with_all_args_nested_structures_as_hash, numberOfItems: nil) }
      let(:analysis_list_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems":#{expected_json_nil_render_value},
            "itemListElement":#{MappersPresenter.new(RootMappers::AnalysisMapper, args[:itemListElement]).to_json}
          }
        JSON
      end

      it { expect(JSON.parse(analysis_list_mapper.to_json)).to eq JSON.parse expected_json }
    end
  end
end
