describe AnalysisMappers::DataSetList::ItemListElement::AttachmentListMapper do
  describe "factories" do
    describe "trait :with_all_args_nested_structures_as_mappers" do
      subject(:factory) { build :attachment_list_mapper, :with_all_args_nested_structures_as_mappers }

      it { expect(factory.instance_variable_get(:@itemListElement).size).to eq 2 }
      it { expect(factory.instance_variable_get(:@itemListElement).size).to eq factory.instance_variable_get :@numberOfItems }
      it { expect(factory.instance_variable_get(:@itemListElement)).to all be_a AnalysisMappers::DataSetList::ItemListElement::AttachmentList::ItemListElementMapper }
    end

    describe "trait :with_all_args_nested_structures_as_hash" do
      subject(:factory) { build :attachment_list_mapper, :with_all_args_nested_structures_as_hash }

      it { expect(factory.instance_variable_get(:@itemListElement).size).to eq 2 }
      it { expect(factory.instance_variable_get(:@itemListElement).size).to eq factory.instance_variable_get :@numberOfItems }
      it { expect(factory.instance_variable_get(:@itemListElement)).to all be_a Hash }
    end
  end

  describe ".new" do
    context "when called without any arguments" do
      let(:attachment_list_mapper) { build :attachment_list_mapper }

      it { expect(attachment_list_mapper).to be_a described_class }
      it { expect(attachment_list_mapper).to be_a ShaleCustom::Mapper }
      it { expect(attachment_list_mapper.numberOfItems).to be_nil }
      it { expect(attachment_list_mapper.itemListElement).to match_array([]) }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for :attachment_list_mapper, :with_all_args_nested_structures_as_mappers }
      let(:attachment_list_mapper) { described_class.new(**args) }

      it { expect(attachment_list_mapper).to be_a described_class }
      it { expect(attachment_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(attachment_list_mapper.itemListElement).to eq args[:itemListElement] }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for :attachment_list_mapper, :with_all_args_nested_structures_as_mappers, itemListElement: nil }
      let(:attachment_list_mapper) { described_class.new(**args) }

      it { expect(attachment_list_mapper).to be_a described_class }
      it { expect(attachment_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(attachment_list_mapper.itemListElement).to be_nil }
    end
  end

  describe ".from_hash" do
    context "when called without any arguments" do
      let(:attachment_list_mapper) { build :attachment_list_mapper }

      it { expect(attachment_list_mapper).to be_a described_class }
      it { expect(attachment_list_mapper.numberOfItems).to be_nil }
      it { expect(attachment_list_mapper.itemListElement).to match_array([]) }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:attachment_list_mapper, :with_all_args_nested_structures_as_hash) }
      let(:attachment_list_mapper) { described_class.from_hash args }

      it { expect(attachment_list_mapper).to be_a described_class }
      it { expect(attachment_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(attachment_list_mapper.itemListElement).to all be_a AnalysisMappers::DataSetList::ItemListElement::AttachmentList::ItemListElementMapper }
      it { expect(attachment_list_mapper.itemListElement.as_json).to eq args[:itemListElement].as_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:attachment_list_mapper, :with_all_args_nested_structures_as_hash, itemListElement: nil) }
      let(:attachment_list_mapper) { described_class.from_hash args }

      it { expect(attachment_list_mapper).to be_a described_class }
      it { expect(attachment_list_mapper.numberOfItems).to eq args[:numberOfItems] }
      it { expect(attachment_list_mapper.itemListElement).to be_nil }
    end
  end

  describe "#to_json" do
    let(:expected_json_nil_render_value) { "null" }

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
      let(:attachment_list_mapper) { described_class.from_hash args }

      let(:expected_json) do
        <<~JSON
          { "numberOfItems":#{args[:numberOfItems]},
            "itemListElement": #{MappersPresenter.new(AnalysisMappers::DataSetList::ItemListElement::AttachmentList::ItemListElementMapper, args[:itemListElement]).to_json} }
        JSON
      end

      it { expect(attachment_list_mapper.to_json).to eq_without_whitespace expected_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:attachment_list_mapper, :with_all_args_nested_structures_as_hash, itemListElement: nil) }
      let(:attachment_list_mapper) { described_class.from_hash args }

      let(:expected_json) do # HINT: Because numberOfItems is the length of itemListElement
        <<~JSON
          { "numberOfItems":#{expected_json_nil_render_value},
            "itemListElement":#{expected_json_nil_render_value} }
        JSON
      end

      it { expect(attachment_list_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  describe "#to_xml" do
    context "when called without any arguments" do
      let(:attachment_list_mapper) { build :attachment_list_mapper }

      let(:expected_xml) do
        # HINT: It seems that render_nil does work for simple types and for HashMap like structures,
        #       but it omits the tag when an empty array is present. Either this is to be accepted behavior,
        #       or we need to extend Shale for our wishes.
        <<~XML
          <attachmentList>
            <numberOfItems/>
          </attachmentList>
        XML
      end

      it { expect(attachment_list_mapper.to_xml).to eq_without_whitespace expected_xml }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:attachment_list_mapper, :with_all_args_nested_structures_as_hash) }
      let(:attachment_list_mapper) { described_class.from_hash args }

      let(:expected_xml) do
        <<~XML
          <attachmentList>
            <numberOfItems>2</numberOfItems>
            #{args[:itemListElement].map { |hash| AnalysisMappers::DataSetList::ItemListElement::AttachmentList::ItemListElementMapper.from_hash(hash).to_xml }.join("")}
          </attachmentList>
        XML
      end

      it { expect(Hash.from_xml(attachment_list_mapper.to_xml)).to eq(Hash.from_xml(expected_xml)) }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:attachment_list_mapper, :with_all_args_nested_structures_as_hash, itemListElement: nil) }
      let(:attachment_list_mapper) { described_class.from_hash args }

      let(:expected_xml) do
        <<~XML
          <attachmentList>
            <numberOfItems/>
            <itemListElement/>
          </attachmentList>
        XML
      end

      it { expect(attachment_list_mapper.to_xml).to eq_without_whitespace expected_xml }
    end
  end
end
