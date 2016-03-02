require 'block_challenges/challenges'

RSpec.describe 'block challenges' do
  describe 'yield_with_while_loop iterates over the array using only #length and #[] and calls the block with every element' do
    example 'no elements' do
      called_with = []
      yield_with_while_loop(PrimitiveArray[]) { |char| called_with << char }
      assert_equal [], called_with
    end

    example 'one element' do
      called_with = []
      yield_with_while_loop(PrimitiveArray["a"]) { |char| called_with << char }
      assert_equal ["a"], called_with
    end

    example 'two elements' do
      called_with = []
      yield_with_while_loop(PrimitiveArray["a", "b"]) { |char| called_with << char }
      assert_equal ["a", "b"], called_with
    end

    example '100 elements' do
      elements    = 100.times.map { rand 10_000 }
      primitive   = PrimitiveArray.new elements
      called_with = []
      yield_with_while_loop primitive do |char|
        called_with << char
      end
      assert_equal elements, called_with
    end
  end
end
