require 'block_challenges/challenges'

RSpec.describe 'PubSubSimple' do
  let(:pss) { PubSubSimple.new }

  it 'lets code subscribe to events' do
    pss.subscribe { }
  end

  it 'raises a LocalJumpError when subscribe is called without a block' do
    raised = false
    begin
      pss.subscribe
    rescue LocalJumpError => err
      raised = true
      assert_equal "no block given", err.message
    end
    assert_equal true, raised
  end

  it 'calls the subscriber whenever publish is invoked' do
    times_called = 0
    pss.subscribe { times_called += 1 }
    assert_equal 0, times_called
    pss.publish
    assert_equal 1, times_called
    pss.publish
    assert_equal 2, times_called
  end

  it 'can replace the subscriber with a different subscriber' do
    seen = []
    pss.subscribe { seen << :a }
    pss.publish
    pss.publish
    assert_equal [:a, :a], seen
    pss.subscribe { seen << :b }
    pss.publish
    pss.publish
    assert_equal [:a, :a, :b, :b], seen
  end

  it 'doesn\'t blow up when publishing without a subscriber' do
    pss.publish
  end

  it 'allows the publisher to pass a value to the subscriber' do
    published = []
    pss.subscribe { |value| published << value }
    pss.publish :connection_established
    pss.publish :connection_lost
    assert_equal [:connection_established, :connection_lost], published
  end
end
