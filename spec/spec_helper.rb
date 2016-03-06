$devmode = ENV['DEVMODE']

if $devmode
  $LOAD_PATH.unshift File.expand_path("../solutions", __dir__)
end

module SpecHelpers
  def assert_equal(expected, actual)
    expect(actual).to eq expected
  end

  def i_see_this_helpful_stuff_here(see_it)
    see_it || $devmode || raise("set to true after you've looked at it")
  end
end

RSpec.configure do |config|
  # make spec helpers available in the tests, eg this is where we get the assert_equal from
  config.include SpecHelpers

  # omit the assert_equal body from the backtrace
  config.backtrace_exclusion_patterns << /`assert_equal'/
  config.backtrace_exclusion_patterns << /`i_see_this_helpful_stuff_here'/

  # stop after the first failure
  config.fail_fast = true
end
