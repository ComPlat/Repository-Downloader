class HashNormalizer
  def initialize(hash) = @hash = hash

  def normalized_hash = normalize_hash(@hash)

  private

  def normalize_hash(hash, parent_key = nil)
    normalized_hash = {}
    hash.each do |key, value|
      normalized_key = parent_key ? "#{parent_key}.#{key}" : key
      if value.is_a?(Hash)
        normalized_hash.merge!(normalize_hash(value, normalized_key))
      elsif value.is_a?(Array)
        value.each.with_index(1) { |item, index|
          normalized_hash.merge!(normalize_hash(item, normalized_key + index.to_s))
        }
      else
        normalized_hash[normalized_key] = value
      end
    end
    normalized_hash
  end
end
