require 'block_challenges/challenges'

RSpec.describe 'block challenges' do
  describe 'block_to_proc' do
    it 'receives a block and returns it' do
      called = false
      prc = block_to_proc { called = true }
      assert_equal false, called
      prc.call
      assert_equal true, called
    end

    example 'this allows you to call it later' do
      num = 0
      b1  = block_to_proc { num = 1 }
      b2  = block_to_proc { num = 2 }

      assert_equal 1, b1.call
      assert_equal 1, num

      assert_equal 2, b2.call
      assert_equal 2, num

      assert_equal 1, b1.call
      assert_equal 1, num

      assert_equal 2, b2.call
      assert_equal 2, num
    end

    it 'does not call the block' do
      called = false
      block_to_proc { called = true }
      assert_equal false, called
    end
  end
end
