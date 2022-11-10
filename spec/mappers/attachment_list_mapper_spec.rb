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
    let(:args) { attributes_for :attachment_list_mapper, :with_all_args }
    let(:attachment_list_mapper) { described_class.new(**args) }

    it { expect(attachment_list_mapper).to be_a described_class }
    it { expect(attachment_list_mapper.numberOfItems).to eq args[:numberOfItems] }
    it { expect(attachment_list_mapper.itemListElement).to eq args[:itemListElement] }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON
          {
            "numberOfItems":#{args[:numberOfItems]},
            "itemListElement":[
              {
                "@type":"AttachmentEntity",
                "identifier":"a63e278b-22f2-4da3-955f-e80e197bc853",
                "filename":"BJ68_1H.zip",
                "filepath":"data/a63e278b-22f2-4da3-955f-e80e197bc853"
              },
              {
                "@type":"AttachmentEntity",
                "identifier":"a63e278b-22f2-4da3-955f-e80e197bc853",
                "filename":"HRMS.jpg",
                "filepath":"data/a63e278b-22f2-4da3-955f-e80e197bc853"
              }
            ]
          }
        JSON
      end

      it { expect(attachment_list_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
