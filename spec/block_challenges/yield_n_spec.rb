require 'block_challenges/challenges'

RSpec.describe 'block challenges' do
  specify 'yield_two calls the block with both items from an array' do
    called_with = []
    yield_two(["a", "b"]) { |char| called_with << char }
    assert_equal ["a", "b"], called_with
  end

  specify 'yield_three calls the block with three items from an array' do
    called_with = []
    yield_three(["a", "b", "c"]) { |char| called_with << char }
    assert_equal ["a", "b", "c"], called_with
  end

  specify 'yield_four calls the block with four items from an array' do
    called_with = []
    yield_four(["a", "b", "c", "d"]) { |char| called_with << char }
    assert_equal ["a", "b", "c", "d"], called_with
  end

  specify 'yield_five calls the block with five items from an array' do
    called_with = []
    yield_five(["a", "b", "c", "d", "e"]) { |char| called_with << char }
    assert_equal ["a", "b", "c", "d", "e"], called_with
  end

  specify 'yield_six calls the block with six items from an array' do
    called_with = []
    yield_six(["a", "b", "c", "d", "e", "f"]) { |char| called_with << char }
    assert_equal ["a", "b", "c", "d", "e", "f"], called_with
  end

  specify 'yield_seven calls the block with seven items from an array' do
    called_with = []
    yield_seven(["a", "b", "c", "d", "e", "f", "g"]) { |char| called_with << char }
    assert_equal ["a", "b", "c", "d", "e", "f", "g"], called_with
  end

  specify 'yield_eight calls the block with eight items from an array' do
    called_with = []
    yield_eight(["a", "b", "c", "d", "e", "f", "g", "h"]) { |char| called_with << char }
    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h"], called_with
  end

  specify 'yield_nine calls the block with nine items from an array' do
    called_with = []
    yield_nine(["a", "b", "c", "d", "e", "f", "g", "h", "i"]) { |char| called_with << char }
    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i"], called_with
  end

  specify 'yield_ten calls the block with ten items from an array' do
    called_with = []
    yield_ten([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) { |char| called_with << char }
    assert_equal [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], called_with
  end
end
