$devmode = ENV['DEVMODE']

if $devmode
  $LOAD_PATH.unshift File.expand_path("../solutions", __dir__)
end

require 'nokogiri'

module SpecHelpers
  def assert_equal(expected, actual)
    expect(actual).to eq expected
  end

  def i_see_this_helpful_stuff_here(see_it)
    see_it || $devmode || raise("set to true after you've looked at it")
  end

  def assert_raises(error_class, error_message=nil, &block)
    expect(&block).to raise_error(error_class, error_message)
  end

  def assert_html_equal(expected_html, actual_html)
    my_nodes, your_nodes = [expected_html, actual_html].map { |html| html_data html }
    assert_equal my_nodes, your_nodes
  end

  private

  def html_data(html)
    Nokogiri::HTML(html).css('*').map { |n| [n.path, html_node_data(n)] }.to_h
  end

  def html_node_data(node)
    { name:  node.name,
      path:  node.path,
      attrs: node.attributes.map { |n, v| [n, v.value] }.to_h,
      text:  node.children.select { |child| child.name == 'text' }.map(&:text).map(&:strip).join,
    }
  end
end

RSpec.configure do |config|
  # make spec helpers available in the tests, eg this is where we get the assert_equal from
  config.include SpecHelpers

  # omit the assert_equal body from the backtrace
  config.backtrace_exclusion_patterns << /`assert_equal'/
  config.backtrace_exclusion_patterns << /`i_see_this_helpful_stuff_here'/
  config.backtrace_exclusion_patterns << /`assert_raises'/

  # stop after the first failure
  config.fail_fast = true
end
