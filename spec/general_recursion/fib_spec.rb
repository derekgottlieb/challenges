require 'general_recursion/challenge'

RSpec.describe 'general recursion' do
  describe 'fib' do
    it 'returns 0 when given 0' do
      assert_equal 0, fib(0)
    end

    it 'returns 1 when given 1' do
      assert_equal 1, fib(1)
    end

    it 'returns 1 when given 2' do
      assert_equal 1, fib(2)
    end

    it 'returns 2 when given 3' do
      assert_equal 2, fib(3)
    end

    it 'returns 3 when given 4' do
      assert_equal 3, fib(4)
    end

    it 'returns 5 when given 5' do
      assert_equal 5, fib(5)
    end

    it 'returns 8 when given 6' do
      assert_equal 8, fib(6)
    end

    it 'returns 13 when given 7' do
      assert_equal 13, fib(7)
    end

    it 'returns 21 when given 8' do
      assert_equal 21, fib(8)
    end

    it 'returns 34 when given 9' do
      assert_equal 34, fib(9)
    end

    it 'returns 55 when given 10' do
      assert_equal 55, fib(10)
    end

    it 'returns 89 when given 11' do
      assert_equal 89, fib(11)
    end

    it 'returns 144 when given 12' do
      assert_equal 144, fib(12)
    end

    it 'returns 233 when given 13' do
      assert_equal 233, fib(13)
    end

    it 'returns 377 when given 14' do
      assert_equal 377, fib(14)
    end

    it 'returns 610 when given 15' do
      assert_equal 610, fib(15)
    end

    it 'returns 987 when given 16' do
      assert_equal 987, fib(16)
    end

    it 'returns 1597 when given 17' do
      assert_equal 1597, fib(17)
    end

    it 'returns 2584 when given 18' do
      assert_equal 2584, fib(18)
    end

    it 'returns 4181 when given 19' do
      assert_equal 4181, fib(19)
    end
  end
end
