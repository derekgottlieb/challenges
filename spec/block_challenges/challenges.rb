require 'spec_helper'
require 'block_challenges'

RSpec.describe 'block challenges' do
  describe 'wrap' do
    it 'receives a value and returns a block' do
      assert_equal Proc, wrap(2).class
    end
    specify 'when you call the returned block, you get the value you passed in' do
      assert_equal 2, wrap(2).call
    end
  end
end


RSpec.describe 'block challenges' do
  specify 'call_twice calls the block two times' do
    i = 0
    call_twice { i += 1 }
    assert_equal 2, i
  end

  specify 'call_thrice calls the block three times' do
    i = 0
    call_thrice { i += 1 }
    assert_equal 3, i
  end
end


RSpec.describe 'block challenges' do
  describe 'yield_first' do
    it 'when the array is empty, does nothing' do
      times_called = 0
      called_with = :unset
      yield_first([]) { |char| called_with = char }
      assert_equal :unset, called_with
      assert_equal 0, times_called
    end

    it 'when the array is not empty, it calls the block with the first item from an array' do
      times_called = 0
      called_with  = :unset
      yield_first(["a", "b"]) { |char| called_with = char }
      assert_equal 1, times_called
      assert_equal "a", called_with
    end

    it 'doesn\'t get confused by an array with nil in it vs an empty array' do
      times_called = 0
      called_with = :unset
      yield_first([nil]) { |char| called_with = char }
      assert_equal nil, called_with
      assert_equal 1, times_called
    end
  end
end

__END__
RSpec.describe 'block challenges' do
'yield_two calls the block with both items from an array'
called_with = []
yield_two(["a", "b"]) { |char| called_with << char }
assert_equal ["a", "b"], times_called

'yield_three calls the block with three items from an array'
called_with = []
yield_three(["a", "b", "c"]) { |char| called_with << char }
assert_equal ["a", "b", "c"], times_called

'yield_four calls the block with three items from an array'
called_with = []
yield_four(["a", "b", "c", "d"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d"], times_called

'yield_five calls the block with three items from an array'
called_with = []
yield_five(["a", "b", "c", "d", "e"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d", "e"], times_called

'yield_six calls the block with six items from an array'
called_with = []
yield_six(["a", "b", "c", "d", "e", "f"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d", "e", "f"], times_called

'yield_seven calls the block with seven items from an array'
called_with = []
yield_seven(["a", "b", "c", "d", "e", "f", "g"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d", "e", "f", "g"], times_called

'yield_eight calls the block with eight items from an array'
called_with = []
yield_eight(["a", "b", "c", "d", "e", "f", "g", "h"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d", "e", "f", "g", "h"], times_called

'yield_nine calls the block with nine items from an array'
called_with = []
yield_nine(["a", "b", "c", "d", "e", "f", "g", "h", "i"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i"], times_called

'yield_ten calls the block with ten items from an array'
called_with = []
yield_ten([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) { |char| called_with << char }
assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], times_called

'yield_em_all calls the block with every item from an array'
called_with = []
yield_em_all(BracketsOnly[]) { |char| called_with << char }
assert_equal [], times_called

called_with = []
yield_em_all(BracketsOnly["a"]) { |char| called_with << char }
assert_equal ["a"], times_called

called_with = []
yield_em_all(BracketsOnly["a", "b"]) { |char| called_with << char }
assert_equal ["a", "b"], times_called

called_with = []
yield_em_all(BracketsOnly["a", "b", "c"]) { |char| called_with << char }
assert_equal ["a", "b", "c"], times_called

called_with = []
yield_em_all(BracketsOnly["a", "b", "c", "d"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d"], times_called

called_with = []
yield_em_all(BracketsOnly["a", "b", "c", "d", "e"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d", "e"], times_called

called_with = []
yield_em_all(BracketsOnly["a", "b", "c", "d", "e", "f"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d", "e", "f"], times_called

called_with = []
yield_em_all(BracketsOnly["a", "b", "c", "d", "e", "f", "g"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d", "e", "f", "g"], times_called

called_with = []
yield_em_all(BracketsOnly["a", "b", "c", "d", "e", "f", "g", "h"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d", "e", "f", "g", "h"], times_called

called_with = []
yield_em_all(BracketsOnly["a", "b", "c", "d", "e", "f", "g", "h", "i"]) { |char| called_with << char }
assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i"], times_called

yield_em_all(BracketsOnly[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) { |char| called_with << char }
assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], times_called


'best_advice returns the first element from an array where the block returned true'
best_advice([1,5,2]) { |n| n == 1 } # => 1
best_advice([1,5,2]) { |n| n == 5 } # => 5
best_advice([1,5,2]) { |n| n == 2 } # => 2
best_advice([1,5,2]) { |n| n == 8 } # => nil
best_advice([1,5,2]) { |n| true }   # => 1


'block_and_forth_forever receives a block, and calls it with a block that doubles whatever it receives'
results = []
block_and_forth_forever do |&block|
  results << block.call(3)
  results << block.call(2)
  results << block.call(1)
end
assert_equal [3, 2, 1], results


'blinked_list_unshift returns a block where, if I call it with :data, it gives me the data, and if I call it with :link, it gives me the original block'
  'blinked_list_data returns the data, if there is a node'
  'blinked_list_link returns the link, if there is a node'
  list = blinked_list_unshift 1, nil
  list = blinked_list_unshift 'a', list
  list = blinked_list_unshift :lol, list
  list.call(:data) # => :lol
  list.call(:link).call(:datta) # => "a"
  list.call(:link).call(:link).call(:datta) # => 1
  list.call(:link).call(:link).call(:link) # => nil

  blinked_list_data list # => :lol
  list = blinked_list_link list
  blinked_list_data list # => "a"
  list = blinked_list_link list
  blinked_list_data list # => 1
  list = blinked_list_link list
  assert_equal nil, list
