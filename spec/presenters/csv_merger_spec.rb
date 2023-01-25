# frozen_string_literal: true

describe CsvMerger do
  let(:reaction) { create(:reaction, :with_realistic_attributes, reaction_description: "reaction_description") } # HINT: Otherwise test is very complicated.
  let(:sample) { create(:sample, :with_realistic_attributes, reaction:) }
  let(:csv_strings) {
    {reaction_csv_string: reaction.present_to_api.to_csv.to_a.join,
     sample_csv_string: sample.present_to_api.to_csv.to_a.join}
  }

  describe ".new" do
    it { expect(described_class.new([csv_strings[:reaction_csv_string], csv_strings[:sample_csv_string]])).to be_a described_class }
  end

  describe "#merged_csv" do
    subject(:merged_csv_string) { described_class.new([csv_strings[:reaction_csv_string], csv_strings[:sample_csv_string]]).merged_csv_string }

    let(:csv_helper_hash) {
      {reaction_csv: CSV.parse(csv_strings[:reaction_csv_string], headers: true),
       sample_csv: CSV.parse(csv_strings[:sample_csv_string], headers: true),
       merged_csv_reaction_values: merged_csv_rows.second.map { |value| value.nil? ? "" : value },
       merged_csv_sample_values: merged_csv_rows.third.map { |value| value.nil? ? "" : value }}
    }

    let(:merged_csv) { CSV.parse(merged_csv_string, headers: true) }
    let(:merged_csv_rows) { merged_csv.to_a }

    let(:csv_rows) {
      {reaction_csv_rows: csv_helper_hash[:reaction_csv].to_a,
       sample_csv_rows: csv_helper_hash[:sample_csv].to_a}
    }

    it { is_expected.to be_a String }

    describe "rows" do
      it { expect(merged_csv_rows).to all(all(be_a(String).or(be_nil))) }
      it { expect(merged_csv_rows.size).to eq csv_rows[:reaction_csv_rows].size + csv_rows[:sample_csv_rows].size - 1 }
      it { expect(merged_csv_rows.size).to eq 3 }
    end

    describe "headers" do
      it { expect(merged_csv.headers).to all be_a String }
      it { expect(merged_csv.headers).to include(*(csv_helper_hash[:reaction_csv].headers + csv_helper_hash[:sample_csv].headers)) }
      it { expect(merged_csv.headers.size).to eq (csv_helper_hash[:reaction_csv].headers + csv_helper_hash[:sample_csv].headers).uniq.size }
      it { expect(merged_csv.headers).to match_array((csv_helper_hash[:reaction_csv].headers + csv_helper_hash[:sample_csv].headers).uniq) }
    end

    describe "reaction row" do
      let(:reaction_csv_values) { csv_rows[:reaction_csv_rows].second.map { |value| value.nil? ? "" : value } }

      it { expect(csv_helper_hash[:merged_csv_reaction_values]).to all be_a String }
      it { expect(csv_helper_hash[:merged_csv_reaction_values].size).to eq merged_csv.headers.size }

      it {
        expect(merged_csv.headers.zip(csv_helper_hash[:merged_csv_reaction_values]).to_h)
          .to eq((merged_csv.headers - csv_helper_hash[:reaction_csv].headers).index_with { |header| "" }
                   .merge(csv_helper_hash[:reaction_csv].headers.zip(reaction_csv_values).to_h))
      }
    end

    describe "sample row" do
      let(:sample_csv_values) { csv_rows[:sample_csv_rows].second.map { |value| value.nil? ? "" : value } }

      it { expect(csv_helper_hash[:merged_csv_sample_values]).to all be_a String }
      it { expect(csv_helper_hash[:merged_csv_sample_values].size).to eq merged_csv.headers.size }

      it {
        expect(merged_csv.headers.zip(csv_helper_hash[:merged_csv_sample_values]).to_h)
          .to eq((merged_csv.headers - csv_helper_hash[:sample_csv].headers).index_with { |header| "" }
                   .merge(csv_helper_hash[:sample_csv].headers.zip(sample_csv_values).to_h))
      }
    end
  end
end
