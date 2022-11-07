RSpec::Matchers.define :eq_without_whitespace do |expected|
  match { |actual| actual.to_s.delete(" \t\r\n\ ") == expected.to_s.delete(" \t\r\n\ ") }
end
