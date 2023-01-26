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
    normalized_hash_array = [HashNormalizer.new(obj.second).normalized_hash]

    flattened_headers = normalized_hash_array.flat_map { |row| row.keys }.uniq

    flattened_obj = []
    flattened_obj[0] = Hash[*flattened_headers.collect { |header| [header, header] }.flatten]
    flattened_obj[1] = Hash[*normalized_hash_array[0].collect { |value| [value] }.flatten]

    ::CSV.generate(**options) do |csv|
      flattened_obj.each do |row|
        values = []

        flattened_headers.each do |header|
          values << row[header]
        end

        csv << values
      end
    end
  end
end
