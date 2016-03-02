require 'block_challenges/challenges'

RSpec.describe 'block challenges' do
  describe 'yield_first' do
    it 'when the array is empty, does nothing' do
      called_with = []
      yield_first([]) { |char| called_with << char }
      assert_equal [], called_with
    end

    it 'when the array is not empty, it calls the block with the first item from an array' do
      called_with = []
      yield_first(["a", "b"]) { |char| called_with << char }
      assert_equal ["a"], called_with
    end

    it 'doesn\'t get confused by an array with nil in it vs an empty array' do
      called_with = []
      yield_first([nil]) { |val| called_with << val }
      assert_equal [nil], called_with
    end
  end
end
