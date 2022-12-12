describe RootMappers::ReactionMapper do
  let(:expected_json_nil_render_value) { "null" }
  let(:reagents_list_mapper) { build(:reagents_list_mapper, :with_all_args) }

  describe ".new" do
    context "when called without any arguments" do
      let(:reaction_mapper) { build(:reaction_mapper) }

      it { expect(reaction_mapper).to be_a described_class }
      it { expect(reaction_mapper).to be_a ShaleCustom::Mapper }
      it { expect(reaction_mapper.context).to be_nil }
      it { expect(reaction_mapper.id).to be_nil }
      it { expect(reaction_mapper.type).to be_nil }
      it { expect(reaction_mapper.name).to be_nil }
      it { expect(reaction_mapper.identifier).to be_nil }
      it { expect(reaction_mapper.status).to be_nil }
      it { expect(reaction_mapper.description).to be_nil }
      it { expect(reaction_mapper.temperature).to be_nil }
      it { expect(reaction_mapper.reaction_type).to be_nil }
      it { expect(reaction_mapper.duration).to be_nil }
      it { expect(reaction_mapper.purification).to be_nil }
      it { expect(reaction_mapper.reagents_list).to be_nil }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:reaction_mapper, :with_all_args) }
      let(:reaction_mapper) { described_class.new(**args) }

      it { expect(reaction_mapper).to be_a described_class }
      it { expect(reaction_mapper.context).to eq args[:context] }
      it { expect(reaction_mapper.id).to eq args[:id] }
      it { expect(reaction_mapper.type).to eq args[:type] }
      it { expect(reaction_mapper.name).to eq args[:name] }
      it { expect(reaction_mapper.identifier).to eq args[:identifier] }
      it { expect(reaction_mapper.status).to eq args[:status] }
      it { expect(reaction_mapper.description).to eq args[:description] }
      it { expect(reaction_mapper.temperature).to eq args[:temperature] }
      it { expect(reaction_mapper.reaction_type).to eq args[:reaction_type] }
      it { expect(reaction_mapper.duration).to eq args[:duration] }
      it { expect(reaction_mapper.purification).to eq args[:purification] }
      it { expect(reaction_mapper.reagents_list).to eq args[:reagents_list] }
      it { expect(reaction_mapper.reagents_list.to_json).to eq_without_whitespace reagents_list_mapper.to_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:reaction_mapper, :with_all_args, name: nil, identifier: nil) }
      let(:reaction_mapper) { described_class.new(**args) }

      it { expect(reaction_mapper).to be_a described_class }
      it { expect(reaction_mapper.context).to eq args[:context] }
      it { expect(reaction_mapper.id).to eq args[:id] }
      it { expect(reaction_mapper.type).to eq args[:type] }
      it { expect(reaction_mapper.name).to eq args[:name] }
      it { expect(reaction_mapper.identifier).to eq args[:identifier] }
      it { expect(reaction_mapper.status).to eq args[:status] }
      it { expect(reaction_mapper.description).to eq args[:description] }
      it { expect(reaction_mapper.temperature).to eq args[:temperature] }
      it { expect(reaction_mapper.reaction_type).to eq args[:reaction_type] }
      it { expect(reaction_mapper.duration).to eq args[:duration] }
      it { expect(reaction_mapper.purification).to eq args[:purification] }
      it { expect(reaction_mapper.reagents_list).to eq args[:reagents_list] }
      it { expect(reaction_mapper.reagents_list.to_json).to eq_without_whitespace reagents_list_mapper.to_json }
    end
  end

  describe "#to_json" do
    context "when called without any arguments" do
      let(:reaction_mapper) { build(:reaction_mapper) }

      let(:expected_json) do
        <<~JSON
          {
            "@context": #{expected_json_nil_render_value},
            "@id": #{expected_json_nil_render_value},
            "@type": #{expected_json_nil_render_value},
            "name": #{expected_json_nil_render_value},
            "identifier": #{expected_json_nil_render_value},
            "status": #{expected_json_nil_render_value},
            "description": #{expected_json_nil_render_value},
            "temperature": #{expected_json_nil_render_value},
            "reactionType": #{expected_json_nil_render_value},        
            "duration": #{expected_json_nil_render_value},
            "purification": #{expected_json_nil_render_value},
            "reagentsList": #{expected_json_nil_render_value}
          }
        JSON
      end

      it { expect(reaction_mapper.to_json).to eq_without_whitespace expected_json }
    end

    context "when called with all arguments" do
      let(:args) { attributes_for(:reaction_mapper, :with_all_args) }
      let(:reaction_mapper) { described_class.new(**args) }

      let(:expected_json) do
        <<~JSON
          {
            "@context":"#{args[:context]}",
            "@id":"#{args[:id]}",
            "@type":"#{args[:type]}",
            "name":"#{args[:name]}",
            "identifier":"#{args[:identifier]}",
            "status":"#{args[:status]}",
            "description":"#{args[:description]}",
            "temperature":"#{args[:temperature]}",
            "reactionType":"#{args[:reaction_type]}",
            "duration":"#{args[:duration]}",
            "purification":"#{args[:purification]}",
            "reagentsList": #{reagents_list_mapper.to_json}
          }
        JSON
      end

      it { expect(reaction_mapper.to_json).to eq_without_whitespace expected_json }
    end

    context "when called with some arguments" do
      let(:args) { attributes_for(:reaction_mapper, :with_all_args, name: nil, identifier: nil) }
      let(:reaction_mapper) { described_class.new(**args) }

      let(:expected_json) do
        <<~JSON
          {
            "@context":"#{args[:context]}",
            "@id":"#{args[:id]}",
            "@type":"#{args[:type]}",
            "name":#{expected_json_nil_render_value},
            "identifier":#{expected_json_nil_render_value},
            "status":"#{args[:status]}",
            "description":"#{args[:description]}",
            "temperature":"#{args[:temperature]}",
            "reactionType":"#{args[:reaction_type]}",
            "duration":"#{args[:duration]}",
            "purification":"#{args[:purification]}",
            "reagentsList": #{reagents_list_mapper.to_json}
          }
        JSON
      end

      it { expect(reaction_mapper.to_json).to eq_without_whitespace expected_json }
    end
  end
end
