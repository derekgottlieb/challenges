require 'general_recursion/challenge'


RSpec.describe 'general recursion' do
  describe 'spiral_access' do
    def assert_yielded(expected, ary_of_arys)
      seen = []
      spiral_access(ary_of_arys) { |element| seen << element }
      expect(seen).to eq expected
    end

    it 'does not call the block when there is nothing to iterate over' do
      expect {
        spiral_access([[]]) { raise "You invoked the block" }
      }.to_not raise_error
    end

    example '1 by 1' do
      assert_yielded [1], [[1]]
    end

    example '2 by 2' do
      rows = [
        [1,2],
        [4,3]
      ]
      assert_yielded [1,2,3,4], rows
    end

    example '3 by 3' do
      rows = [
        [1,2,3],
        [8,9,4],
        [7,6,5],
      ]
      assert_yielded [1,2,3,4,5,6,7,8,9], rows
    end

    example 'the example' do
      expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25]
      rows = [
        [  1 ,  2 ,  3 ,  4 , 5 ],
        [ 16 , 17 , 18 , 19 , 6 ],
        [ 15 , 24 , 25 , 20 , 7 ],
        [ 14 , 23 , 22 , 21 , 8 ],
        [ 13 , 12 , 11 , 10 , 9 ],
      ]
      assert_yielded expected, rows
    end

    example '6 by 6' do
      rows = [
        [  1 ,  2 ,  3 ,  4 ,  5 ,  6 ],
        [ 20 , 21 , 22 , 23 , 24 ,  7 ],
        [ 19 , 32 , 33 , 34 , 25 ,  8 ],
        [ 18 , 31 , 36 , 35 , 26 ,  9 ],
        [ 17 , 30 , 29 , 28 , 27 , 10 ],
        [ 16 , 15 , 14 , 13 , 12 , 11 ],
      ]
      assert_yielded (1..36).to_a, rows
    end

    example 'chars instead of ints' do
      rows = [
        %w[1 2 3],
        %w[8 9 4],
        %w[7 6 5],
      ]
      assert_yielded %w[1 2 3 4 5 6 7 8 9], rows
    end

    example '2 by 3' do
      rows = [
        [1, 2],
        [6, 3],
        [5, 4],
      ]
      assert_yielded [1,2,3,4,5,6], rows
    end

    example '3 by 2' do
      rows = [
        [1, 2, 3],
        [6, 5, 4],
      ]
      assert_yielded [1,2,3,4,5,6], rows
    end
  end
end
