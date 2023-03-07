# frozen_string_literal: true

require "csv"
require_relative "hash_normalizer"

# CSV adapter
#
# @api public
class CustomShaleCsvAdapter
  # Parse CSV into Array<Hash<String, any>>
  #
  # @param [String] csv CSV document
  # @param [Array<String>] headers
  # @param [Hash] options
  #
  # @return [Array<Hash<String, any>>]
  #
  # @api private
  def self.load(csv, headers:, **options)
    # HINT: This implementation is naive and has to be improved when CustomShaleCsvAdapter is used to load csvs
    ::CSV.parse(csv, headers: headers, **options).map(&:to_h)
  end

  # Serialize Array<Hash<String, any>> into CSV
  #
  # @param [Array<Hash<String, any>>] obj Array<Hash<String, any>> object
  # @param [Array<String>] headers
  # @param [Hash] options
  #
  # @return [String]
  #
  # @api private
  def self.dump(obj, headers:, **options)
    normalized_hash = HashNormalizer.new(obj.second).normalized_hash
    flattened_headers = normalized_hash.keys
    flatted_headers_hash = flattened_headers.map { |header| [header, header] }.to_h
    flattened_obj = [flatted_headers_hash, normalized_hash]

    ::CSV.generate(**options) do |csv|
      flattened_obj.each do |row|
        csv << flattened_headers.map { |header| row[header] }
      end
    end
  end
end
