# frozen_string_literal: true

module ZipHelper
  def unzip(io:)
    ZipTricks::FileReader.read_zip_structure(io:).each do |entry|
      Dry::Files.new.write "./tmp/output/#{entry.filename}"
      File.open("./tmp/output/#{entry.filename}", "wb") do |extracted_file|
        inflated_reader = entry.extractor_from io
        extracted_file << inflated_reader.extract until inflated_reader.eof?
      end
    end
  end
end
