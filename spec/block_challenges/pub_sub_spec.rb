require 'block_challenges/challenges'

RSpec.describe 'PubSub' do
  let(:ps) { PubSub.new }

  it 'lets code subscribe to named events' do
    ps.subscribe(:connection_established) { }
  end

  it 'raises a LocalJumpError when subscribe is called without a block' do
    raised = false
    begin
      ps.subscribe(:connection_established)
    rescue LocalJumpError => err
      raised = true
      assert_equal "no block given", err.message
    end
    assert_equal true, raised
  end


  it 'calls the subscriber whenever the event is published' do
    times_called = 0
    ps.subscribe(:connection_established) { times_called += 1 }
    assert_equal 0, times_called
    ps.publish(:connection_established)
    assert_equal 1, times_called
    ps.publish(:connection_established)
    assert_equal 2, times_called
  end

  it 'allows multiple subscribers and calls them all when the event is published' do
    seen = []
    ps.subscribe(:connection_established) { seen << :a }
    ps.subscribe(:connection_established) { seen << :b }
    assert_equal [], seen
    ps.publish(:connection_established)
    assert_equal [:a, :b], seen
    ps.publish(:connection_established)
    assert_equal [:a, :b, :a, :b], seen
  end

  it 'does not call the subscriber when some other event is published' do
    called = false
    ps.subscribe(:connection_established) { called = true }
    ps.publish(:connection_dropped)
    assert_equal false, called
    ps.publish(:connection_established)
    assert_equal true, called
  end

  it 'allows multiple event types to be subscribed to' do
    state = :unset
    ps.subscribe(:connection_established) { state = :established }
    ps.subscribe(:connection_dropped)     { state = :dropped }

    assert_equal :unset, state

    ps.publish :connection_dropped
    assert_equal :dropped, state

    ps.publish :connection_established
    assert_equal :established, state

    ps.publish :connection_dropped
    assert_equal :dropped, state

    ps.publish :connection_established
    assert_equal :established, state
  end

  it 'doesn\'t blow up when publishing without a subscriber' do
    ps.publish :hello
  end

  it 'allows the publisher to pass a value to all the subscribers' do
    published = []
    ps.subscribe(:connection_established) { |value| published << value }
    ps.publish :connection_established, 123
    assert_equal [123], published
  end
end
