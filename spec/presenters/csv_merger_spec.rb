# frozen_string_literal: true

describe CsvMerger do
  let(:csv_strings) {
    reaction = create(:reaction, :with_realistic_attributes)
    sample = create(:sample, :with_realistic_attributes, reaction:)
    {reaction_csv_string: reaction.present_to_api.to_csv.to_a.join,
     sample_csv_string: sample.present_to_api.to_csv.to_a.join}
  }

  describe ".new" do
    it { expect(described_class.new([csv_strings[:reaction_csv_string], csv_strings[:sample_csv_string]])).to be_a described_class }
  end

  describe "#merged_csv" do
    subject(:merged_csv_string) { described_class.new([csv_strings[:reaction_csv_string], csv_strings[:sample_csv_string]]).merged_csv_string }

    let(:expected_csv_table) {
      reaction_csv = CSV.parse(csv_strings[:reaction_csv_string], headers: true)
      reaction_csv_rows = reaction_csv.to_a
      sample_csv = CSV.parse(csv_strings[:sample_csv_string], headers: true)
      sample_csv_rows = sample_csv.to_a
      merged_csv = CSV.parse(merged_csv_string, headers: true)
      merged_csv_rows = merged_csv.to_a

      nil_to_empty_string = ->(value) { value.nil? ? "" : value }

      {reaction_csv:,
       reaction_csv_rows:,
       reaction_csv_values: reaction_csv_rows.second.map(&nil_to_empty_string),
       sample_csv:,
       sample_csv_rows:,
       sample_csv_values: sample_csv_rows.second.map(&nil_to_empty_string),
       merged_csv:,
       merged_csv_headers: merged_csv.headers,
       merged_csv_rows:,
       merged_csv_sample_values: merged_csv_rows.third.map(&nil_to_empty_string),
       merged_csv_reaction_values: merged_csv_rows.second.map(&nil_to_empty_string)}
    }

    it { is_expected.to be_a String }

    describe "rows" do
      it { expect(expected_csv_table[:merged_csv_rows]).to all(all(be_a(String).or(be_nil))) }
      it { expect(expected_csv_table[:merged_csv_rows].size).to eq expected_csv_table[:reaction_csv_rows].size + expected_csv_table[:sample_csv_rows].size - 1 }
      it { expect(expected_csv_table[:merged_csv_rows].size).to eq 3 }
    end

    describe "headers" do
      it { expect(expected_csv_table[:merged_csv_headers]).to all be_a String }
      it { expect(expected_csv_table[:merged_csv_headers]).to include(*(expected_csv_table[:reaction_csv].headers + expected_csv_table[:sample_csv].headers)) }
      it { expect(expected_csv_table[:merged_csv_headers].size).to eq (expected_csv_table[:reaction_csv].headers + expected_csv_table[:sample_csv].headers).uniq.size }
      it { expect(expected_csv_table[:merged_csv_headers]).to match_array((expected_csv_table[:reaction_csv].headers + expected_csv_table[:sample_csv].headers).uniq) }
    end

    describe "reaction row" do
      it { expect(expected_csv_table[:merged_csv_reaction_values]).to all be_a String }
      it { expect(expected_csv_table[:merged_csv_reaction_values].size).to eq expected_csv_table[:merged_csv_headers].size }

      it {
        expect(expected_csv_table[:merged_csv_headers].zip(expected_csv_table[:merged_csv_reaction_values]).to_h)
          .to eq((expected_csv_table[:merged_csv_headers] - expected_csv_table[:reaction_csv].headers).index_with { |_header| "" }
                   .merge(expected_csv_table[:reaction_csv].headers.zip(expected_csv_table[:reaction_csv_values]).to_h))
      }
    end

    describe "sample row" do
      it { expect(expected_csv_table[:merged_csv_sample_values]).to all be_a String }
      it { expect(expected_csv_table[:merged_csv_sample_values].size).to eq expected_csv_table[:merged_csv_headers].size }

      it {
        expect(expected_csv_table[:merged_csv_headers].zip(expected_csv_table[:merged_csv_sample_values]).to_h)
          .to eq((expected_csv_table[:merged_csv_headers] - expected_csv_table[:sample_csv].headers).index_with { |_header| "" }
                   .merge(expected_csv_table[:sample_csv].headers.zip(expected_csv_table[:sample_csv_values]).to_h))
      }
    end
  end
end
