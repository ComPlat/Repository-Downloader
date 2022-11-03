describe PersonMapper do
  context "when called without any arguments" do
    let(:person_mapper) { build :person_mapper }

    let(:expected_nil_return_value) { "null" }

    it { expect(person_mapper).to be_a described_class }
    it { expect(person_mapper.first_name).to be_nil }
    it { expect(person_mapper.last_name).to be_nil }
    it { expect(person_mapper.age).to be_nil }
    it { expect(person_mapper.married).to be false }
    it { expect(person_mapper.hobbies).to eq [] }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON.strip
          {\
          "first_name\":#{expected_nil_return_value},\
          "last_name\":#{expected_nil_return_value},\
          "age\":#{expected_nil_return_value},\
          "married\":false,\
          "hobbies\":[],\
          "address\":#{expected_nil_return_value}}
        JSON
      end

      it { expect(person_mapper.to_json).to eq expected_json }
    end

    describe "#to_xml" do
      let(:expected_xml) do
        <<~XML.strip
          <person>\
          <first_name/>\
          <last_name/>\
          <age/>\
          <married>false</married>\
          <address/>\
          </person>
        XML
      end

      it { expect(person_mapper.to_xml).to eq expected_xml }
    end

    describe "#to_csv" do
      let(:expected_csv) do
        <<~CSV.strip
          ,,,false,[],\n
        CSV
      end

      it { expect(person_mapper.to_csv.strip).to eq expected_csv }
    end
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

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON.strip
          {\
          "first_name":"#{args[:first_name]}",\
          "last_name":"#{args[:last_name]}",\
          "age":#{args[:age]},\
          "married":#{args[:married]},\
          "hobbies":["Guitar","Music","Reading"],\
          "address":{\
          "city":"#{args[:address].city}",\
          "street":"#{args[:address].street}",\
          "zip":"#{args[:address].zip}"\
          }\
          }
        JSON
      end

      it { expect(person_mapper.to_json).to eq expected_json }
    end

    describe "#to_xml" do
      let(:expected_xml) do
        <<~XML
          <person>
            <first_name>#{args[:first_name]}</first_name>
            <last_name>#{args[:last_name]}</last_name>
            <age>#{args[:age]}</age>
            <married>#{args[:married]}</married>
            <hobbies>Guitar</hobbies>
            <hobbies>Music</hobbies>
            <hobbies>Reading</hobbies>
            <address>
            <city>#{args[:address].city}</city>
            <street>#{args[:address].street}</street>
            <zip>#{args[:address].zip}</zip>
            </address>
          </person>
        XML
      end

      it { expect(person_mapper.to_xml).to eq_without_whitespace expected_xml }
    end

    describe "#to_csv" do
      let(:expected_csv) do
        <<~CSV.strip
          #{args[:first_name]},#{args[:last_name]},#{args[:age]},#{args[:married]},\
          \"[\"\"Guitar\"\", \"\"Music\"\", \"\"Reading\"\"]\",\
          \"{\"\"city\"\"=>\"\"#{args[:address].city}"\",\
           \"\"street\"\"=>\"\"#{args[:address].street}"\",\
           \"\"zip\"\"=>\"\"#{args[:address].zip}"\"}\"
        CSV
      end

      it { expect(person_mapper.to_csv.strip).to eq expected_csv }
    end
  end

  context "when called some arguments" do
    let(:args) { attributes_for :person_mapper, :with_all_args, last_name: nil, married: false }
    let(:person_mapper) { described_class.new(**args) }
    let(:expected_nil_return_value) { "null" }

    it { expect(person_mapper).to be_a described_class }
    it { expect(person_mapper.first_name).to eq args[:first_name] }
    it { expect(person_mapper.last_name).to be_nil }
    it { expect(person_mapper.age).to eq args[:age] }
    it { expect(person_mapper.married).to be false }

    describe "#to_json" do
      let(:expected_json) do
        <<~JSON.strip
          {\
          "first_name\":\"#{args[:first_name]}",\
          "last_name\":#{expected_nil_return_value},\
          "age\":#{args[:age]},\
          "married\":#{args[:married]},\
          "hobbies\":[\
          "Guitar\",\
          "Music\",\
          "Reading\"],\
          "address\":{\
          "city\":\"#{args[:address].city}",\
          "street\":\"#{args[:address].street}",\
          "zip\":\"#{args[:address].zip}"}}
        JSON
      end

      it { expect(person_mapper.to_json).to eq expected_json }
    end

    describe "#to_xml" do
      let(:expected_xml) do
        <<~XML.strip
          <person>\
          <first_name>#{args[:first_name]}</first_name>\
          <last_name/>\
          <age>#{args[:age]}</age>\
          <married>#{args[:married]}</married>\
          <hobbies>Guitar</hobbies>\
          <hobbies>Music</hobbies>\
          <hobbies>Reading</hobbies>\
          <address>\
          <city>#{args[:address].city}</city>\
          <street>#{args[:address].street}</street>\
          <zip>#{args[:address].zip}</zip>\
          </address>\
          </person>
        XML
      end

      it { expect(person_mapper.to_xml).to eq expected_xml }
    end

    describe "#to_csv" do
      let(:expected_csv) do
        <<~CSV.strip
          #{args[:first_name]},#{args[:last_name]},#{args[:age]},#{args[:married]},\
          \"[\"\"Guitar\"\", \"\"Music\"\", \"\"Reading\"\"]\",\
          \"{\"\"city\"\"=>\"\"#{args[:address].city}"\",\
           \"\"street\"\"=>\"\"#{args[:address].street}"\",\
           \"\"zip\"\"=>\"\"#{args[:address].zip}"\"}\"\n
        CSV
      end

      it { expect(person_mapper.to_csv.strip).to eq expected_csv }
    end
  end
end
