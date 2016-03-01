module SpecHelpers
  def assert_equal(expected, actual)
    expect(actual).to eq expected
  end
end

RSpec.configure do |config|
  # make spec helpers available in the tests, eg this is where we get the assert_equal from
  config.include SpecHelpers

  # omit the assert_equal body from the backtrace
  config.backtrace_exclusion_patterns << /`assert_equal'/

  # stop after the first failure
  config.fail_fast = true
end
