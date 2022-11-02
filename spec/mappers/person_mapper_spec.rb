describe PersonMapper do
  context "when called without any arguments" do
    let(:person_mapper) { build :person_mapper }

    it { expect(person_mapper).to be_a described_class }
    it { expect(person_mapper.first_name).to be_nil }
    it { expect(person_mapper.last_name).to be_nil }
    it { expect(person_mapper.age).to be_nil }
    it { expect(person_mapper.married).to be false }
    it { expect(person_mapper.hobbies).to eq [] }
    it { expect(person_mapper.to_json).to eq "{\"first_name\":null,\"last_name\":null,\"age\":null,\"married\":false,\"hobbies\":[],\"address\":null}" }
    it { expect(person_mapper.to_xml).to eq "<person><first_name/><last_name/><age/><married>false</married><address/></person>" }
    it { expect(person_mapper.to_csv).to eq ",,,false,[],\n" }
  end

  context "when called with all arguments" do
    let(:args) { attributes_for :person_mapper, :with_all_args }
    let(:person_mapper) { described_class.new(**args) }

    it { expect(person_mapper).to be_a described_class }
    it { expect(person_mapper.first_name).to eq args[:first_name] }
    it { expect(person_mapper.last_name).to eq args[:last_name] }
    it { expect(person_mapper.age).to eq args[:age] }
    it { expect(person_mapper.married).to eq args[:married] }
    it { expect(person_mapper.hobbies).to eq args[:hobbies] }
    it { expect(person_mapper.address.city).to eq args[:address].city }
    it { expect(person_mapper.address.street).to eq args[:address].street }
    it { expect(person_mapper.address.zip).to eq args[:address].zip }

    # TODO: Look to address_mapper_spec.rb as example.
    #       Add describe block around each it block for each method tested.
    #       Move very long eq string to let block within this describe block.
    #       Use string interpolation for values in key-value like data-structures that are represented.
    #       Use Heredoc instead of lengthy strings.
    #       After that Tobias and Rubocop will be happy.
    it do
      expect(person_mapper.to_json)
        .to eq "{\"first_name\":\"John\"," \
                "\"last_name\":\"Doe\"," \
                "\"age\":25," \
                "\"married\":true," \
                "\"hobbies\":[\"Guitar\",\"Music\",\"Reading\"]," \
                "\"address\":{\"city\":\"city\",\"street\":\"street\",\"zip\":\"zip\"}}"
    end

    it do
      expect(person_mapper.to_xml)
        .to eq "<person>" \
                  "<first_name>John</first_name>" \
                  "<last_name>Doe</last_name>" \
                  "<age>25</age>" \
                  "<married>true</married>" \
                  "<hobbies>Guitar</hobbies>" \
                  "<hobbies>Music</hobbies>" \
                  "<hobbies>Reading</hobbies>" \
                  "<address>" \
                    "<city>city</city>" \
                    "<street>street</street>" \
                    "<zip>zip</zip>" \
                  "</address>" \
                "</person>"
    end

    it do
      expect(person_mapper.to_csv)
        .to eq "John,Doe,25,true,\"[\"\"Guitar\"\", \"\"Music\"\", \"\"Reading\"\"]\"," \
                "\"{\"\"city\"\"=>\"\"city\"\", \"\"street\"\"=>\"\"street\"\", \"\"zip\"\"=>\"\"zip\"\"}\"\n"
    end
  end

  context "when called some arguments" do
    let(:person_mapper) { described_class.new first_name:, last_name: nil, age:, hobbies:, address: }

    it { expect(person_mapper).to be_a described_class }
    it { expect(person_mapper.first_name).to eq first_name }
    it { expect(person_mapper.last_name).to be_nil }
    it { expect(person_mapper.age).to eq age }
    it { expect(person_mapper.married).to be false }

    it do
      expect(person_mapper.to_json)
        .to eq "{\"first_name\":\"John\",\"last_name\":null,\"age\":25,\"married\":false," \
                "\"hobbies\":[\"Guitar\",\"Music\",\"Reading\"]," \
                "\"address\":{\"city\":\"city\",\"street\":\"street\",\"zip\":\"zip\"}}"
    end

    it do
      expect(person_mapper.to_xml)
        .to eq "<person>" \
                  "<first_name>John</first_name>" \
                  "<last_name/>" \
                  "<age>25</age>" \
                  "<married>false</married>" \
                  "<hobbies>Guitar</hobbies>" \
                  "<hobbies>Music</hobbies>" \
                  "<hobbies>Reading</hobbies>" \
                  "<address>" \
                    "<city>city</city>" \
                    "<street>street</street>" \
                    "<zip>zip</zip>" \
                  "</address>" \
                "</person>"
    end

    it do
      expect(person_mapper.to_csv)
        .to eq "John,,25,false,\"[\"\"Guitar\"\", \"\"Music\"\", \"\"Reading\"\"]\"," \
               "\"{\"\"city\"\"=>\"\"city\"\", \"\"street\"\"=>\"\"street\"\", \"\"zip\"\"=>\"\"zip\"\"}\"\n"
    end
  end
end
