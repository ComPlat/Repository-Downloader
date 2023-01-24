# frozen_string_literal: true

describe CsvMerger do
  let(:reaction) { create(:reaction, :with_realistic_attributes, reaction_description: "reaction_description") } # HINT: Otherwise test is very complicated.
  let(:sample) { create(:sample, :with_realistic_attributes, reaction:) }
  let(:reaction_csv_string) { reaction.present_to_api.to_csv.to_a.join }
  let(:sample_csv_string) { sample.present_to_api.to_csv.to_a.join }

  describe ".new" do
    it { expect(described_class.new([reaction_csv_string, sample_csv_string])).to be_a described_class }
  end

  describe "#merged_csv" do
    subject(:merged_csv_string) { described_class.new([reaction_csv_string, sample_csv_string]).merged_csv_string }

    let(:merged_csv) { CSV.parse(merged_csv_string, headers: true) }
    let(:merged_csv_rows) { merged_csv.to_a }
    let(:merged_csv_headers) { merged_csv.headers }
    let(:merged_csv_reaction_values) { merged_csv_rows.second.map { |entry| entry.nil? ? "" : entry} }
    let(:merged_csv_sample_values) { merged_csv_rows.third.map { |entry| entry.nil? ? "" : entry} }

    let(:reaction_csv) { CSV.parse(reaction_csv_string, headers: true) }
    let(:reaction_csv_rows) { reaction_csv.to_a }
    let(:reaction_csv_headers) { reaction_csv.headers }
    let(:reaction_csv_values) { reaction_csv_rows.second.map { |entry| entry.nil? ? "" : entry} }

    let(:sample_csv) { CSV.parse(sample_csv_string, headers: true) }
    let(:sample_csv_rows) { sample_csv.to_a }
    let(:sample_csv_headers) { sample_csv.headers }
    let(:sample_csv_values) { sample_csv_rows.second.map { |entry| entry.nil? ? "" : entry} }

    it { is_expected.to be_a String }

    describe 'rows' do
      it { expect(merged_csv_rows).to all(all(be_a(String).or(be_nil))) }
      it { expect(merged_csv_rows.size).to eq reaction_csv_rows.size + sample_csv_rows.size - 1 }
      it { expect(merged_csv_rows.size).to eq 3 }
    end


    describe 'headers' do
      it { expect(merged_csv_headers).to all be_a String }
      it { expect(merged_csv_headers).to include(*(reaction_csv_headers + sample_csv_headers)) }
      it { expect(merged_csv_headers.size).to eq (reaction_csv_headers + sample_csv_headers).uniq.size }
      it { expect(merged_csv_headers).to match_array((reaction_csv_headers + sample_csv_headers).uniq) }
    end

    describe 'reaction row' do
      it { expect(merged_csv_reaction_values).to all be_a String }
      it { expect(merged_csv_reaction_values.size).to eq merged_csv_headers.size }
      it { expect(merged_csv_headers.zip(merged_csv_reaction_values).to_h)
          .to eq((merged_csv_headers - reaction_csv_headers).map{ |header| [header, ""]}.to_h.merge(reaction_csv_headers.zip(reaction_csv_values).to_h))
      }
    end

    describe 'sample row' do
      it { expect(merged_csv_sample_values).to all be_a String }
      it { expect(merged_csv_sample_values.size).to eq merged_csv_headers.size }
      it { expect(merged_csv_headers.zip(merged_csv_sample_values).to_h)
             .to eq((merged_csv_headers - sample_csv_headers).map{ |header| [header, ""]}.to_h.merge(sample_csv_headers.zip(sample_csv_values).to_h))
      }
    end
  end
end
