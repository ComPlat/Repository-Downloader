class CsvMerger

  def initialize(csv_strings)
    @csv_strings = csv_strings
  end

  def merged_csv_string
    CSV.generate do |merged_csv|
      merged_csv << merged_headers
      csv_hashes.each { |row| merged_csv << row.values_at(*merged_headers) }
    end
  end

  private

  def csvs = @csvs ||= @csv_strings.map { |csv_string| CSV.parse(csv_string, headers: true) }

  def merged_headers = @merged_headers ||= csvs.flat_map { |csv| csv.headers }.uniq

  def csv_hashes = csvs.flat_map { |csv| csv.to_a[1..-1].map { |row| csv.headers.zip(row).to_h } }
end