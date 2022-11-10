describe AttachmentListItemListElementMapper do
  let(:expected_json_nil_render_value) { "null" }

  context "when called without any arguments" do
    let(:attachment_list_item_list_element_mapper) { build :attachment_list_item_list_element_mapper }

    it { expect(attachment_list_item_list_element_mapper).to be_a described_class }
    it { expect(attachment_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(attachment_list_item_list_element_mapper.type).to be_nil }
    it { expect(attachment_list_item_list_element_mapper.identifier).to be_nil }
    it { expect(attachment_list_item_list_element_mapper.filename).to be_nil }
    it { expect(attachment_list_item_list_element_mapper.filepath).to be_nil }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "type": #{expected_json_nil_render_value},
            "identifier": #{expected_json_nil_render_value},
            "filename": #{expected_json_nil_render_value},
            "filepath": #{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(attachment_list_item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  context "when called with all arguments" do
    let(:args) { attributes_for :attachment_list_item_list_element_mapper, :with_all_args }
    let(:attachment_list_item_list_element_mapper) { described_class.new(**args) }

    it { expect(attachment_list_item_list_element_mapper).to be_a described_class }
    it { expect(attachment_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(attachment_list_item_list_element_mapper.type).to eq args[:type] }
    it { expect(attachment_list_item_list_element_mapper.identifier).to eq args[:identifier] }
    it { expect(attachment_list_item_list_element_mapper.filename).to eq args[:filename] }
    it { expect(attachment_list_item_list_element_mapper.filepath).to eq args[:filepath] }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "type": "#{args[:type]}",
            "identifier": "#{args[:identifier]}",
            "filename": "#{args[:filename]}",
            "filepath": "#{args[:filepath]}"
          }
        JSON
      end

      it { expect(attachment_list_item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end

  context "when called some arguments" do
    let(:args) { attributes_for :attachment_list_item_list_element_mapper, :with_all_args, identifier: nil, filepath: nil }
    let(:attachment_list_item_list_element_mapper) { described_class.new(**args) }

    it { expect(attachment_list_item_list_element_mapper).to be_a described_class }
    it { expect(attachment_list_item_list_element_mapper).to be_a ShaleCustom::Mapper }
    it { expect(attachment_list_item_list_element_mapper.type).to eq args[:type] }
    it { expect(attachment_list_item_list_element_mapper.identifier).to be_nil }
    it { expect(attachment_list_item_list_element_mapper.filename).to eq args[:filename] }
    it { expect(attachment_list_item_list_element_mapper.filepath).to be_nil }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "type": "#{args[:type]}",
            "identifier": #{expected_json_nil_render_value},
            "filename": "#{args[:filename]}",
            "filepath": #{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(attachment_list_item_list_element_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
