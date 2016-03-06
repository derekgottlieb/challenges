require 'general_recursion/challenge'

RSpec.describe 'general recursion' do
  describe 'two_to_the' do
    it 'returns 1 when given 0' do
      assert_equal 1, two_to_the(0)
    end

    it 'returns 2 when given 1' do
      assert_equal 2, two_to_the(1)
    end

    it 'returns 4 when given 2' do
      assert_equal 4, two_to_the(2)
    end

    it 'returns 8 when given 3' do
      assert_equal 8, two_to_the(3)
    end

    it 'returns 16 when given 4' do
      assert_equal 16, two_to_the(4)
    end

    it 'returns 32 when given 5' do
      assert_equal 32, two_to_the(5)
    end

    it 'returns 64 when given 6' do
      assert_equal 64, two_to_the(6)
    end

    it 'returns 128 when given 7' do
      assert_equal 128, two_to_the(7)
    end

    it 'returns 256 when given 8' do
      assert_equal 256, two_to_the(8)
    end

    it 'returns 512 when given 9' do
      assert_equal 512, two_to_the(9)
    end

    it 'returns 1024 when given 10' do
      assert_equal 1024, two_to_the(10)
    end

    it 'returns 2048 when given 11' do
      assert_equal 2048, two_to_the(11)
    end

    it 'returns 4096 when given 12' do
      assert_equal 4096, two_to_the(12)
    end

    it 'returns 8192 when given 13' do
      assert_equal 8192, two_to_the(13)
    end

    it 'returns 16384 when given 14' do
      assert_equal 16384, two_to_the(14)
    end

    it 'returns 32768 when given 15' do
      assert_equal 32768, two_to_the(15)
    end

    it 'returns 65536 when given 16' do
      assert_equal 65536, two_to_the(16)
    end

    it 'returns 131072 when given 17' do
      assert_equal 131072, two_to_the(17)
    end

    it 'returns 262144 when given 18' do
      assert_equal 262144, two_to_the(18)
    end

    it 'returns 524288 when given 19' do
      assert_equal 524288, two_to_the(19)
    end
  end
end
