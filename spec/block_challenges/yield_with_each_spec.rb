require 'block_challenges/challenges'

RSpec.describe 'block challenges' do
  describe 'yield_with_each iterates over the array using only #each and calls the block with every element' do
    example 'no elements' do
      called_with = []
      yield_with_each(ArrayWithOnlyEach[]) { |char| called_with << char }
      assert_equal [], called_with
    end

    example 'one element' do
      called_with = []
      yield_with_each(ArrayWithOnlyEach["a"]) { |char| called_with << char }
      assert_equal ["a"], called_with
    end

    example 'two elements' do
      called_with = []
      yield_with_each(ArrayWithOnlyEach["a", "b"]) { |char| called_with << char }
      assert_equal ["a", "b"], called_with
    end

    example '100 elements' do
      elements    = 100.times.map { rand 10_000 }
      primitive   = ArrayWithOnlyEach.new elements
      called_with = []
      yield_with_each primitive do |char|
        called_with << char
      end
      assert_equal elements, called_with
    end
  end
end
