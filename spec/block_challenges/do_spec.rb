require 'block_challenges/challenges'

RSpec.describe 'Do' do
  it 'gets initialized with a block' do
    Do.new { }
  end

  describe 'if' do
    it 'calls the initialize-block if invoked with a truthy value' do
      times_called = 0
      d = Do.new { times_called += 1 }
      times_called = 0
      d.if true
      d.if "this is truthy"
      assert_equal 2, times_called
    end
    it 'does not call the initialize-block if invoked with a falsy value' do
      times_called = 0
      d = Do.new { times_called += 1 }
      times_called = 0
      d.if nil
      d.if false
      d.if false
      assert_equal 0, times_called
    end
  end

  describe 'unless' do
    it 'calls the initialize-block if invoked with a falsy value' do
      times_called = 0
      d = Do.new { times_called += 1 }
      times_called = 0
      d.unless nil
      d.unless false
      d.unless false
      assert_equal 3, times_called
    end
    it 'does not call the initialize-block if invoked with a truthy value' do
      times_called = 0
      d = Do.new { times_called += 1 }
      times_called = 0
      d.unless true
      d.unless "this is truthy"
      assert_equal 0, times_called
    end
  end

  describe 'while' do
    it 'calls the initialize-block for as long as the while-block returns a truthy value' do
      return_vals = [100, "abc", :one_two_three, nil, false]
      times_called = 0
      Do.new { times_called += 1 }.while { return_vals.shift }
      assert_equal 3, times_called
      assert_equal [false], return_vals
    end
  end

  describe 'until' do
    it 'calls the initialize-block for as long as the while block returns a falsy value' do
      return_vals = [nil, false, nil, nil, false, 1, 2, 3]
      times_called = 0
      Do.new { times_called += 1 }.until { return_vals.shift }
      assert_equal 5, times_called
      assert_equal [2, 3], return_vals
    end
  end
end
