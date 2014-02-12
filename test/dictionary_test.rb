require 'test_helper'

class DictionaryTest < Test::Unit::TestCase
  include Spout::Tests

  VALID_UNITS = ['years', 'minutes', 'percent', 'events per hour', 'kilograms', 'centimeters', 'standard deviations', 'kilograms per meters-squared',
    'millimeters of mercury']

  def assert_units(units, msg = nil)
    full_message = build_message(msg, "? invalid units. Valid types: #{VALID_UNITS.join(', ')}", units)
    assert_block(full_message) do
      VALID_UNITS.include?(units)
    end
  end

  Dir.glob("variables/**/*.json").each do |file|
    if ['numeric','integer'].include?(json_value(file, :type))
      define_method("test_units: "+file) do
        assert_units json_value(file, :units)
      end
    end
  end
end
