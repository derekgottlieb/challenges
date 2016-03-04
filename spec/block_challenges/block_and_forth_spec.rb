require 'block_challenges/challenges'

RSpec.describe 'block_and_forth' do
  it 'receives a block, and calls it' do
    called = false
    block_and_forth do
      called = true
    end
    assert_equal true, called
  end

  it 'calls it with a block' do
    block_and_forth do |&block|
      assert_equal Proc, block.class
    end
  end

  specify 'the block it passes doubles whatever it receives' do
    block_and_forth do |&block|
      assert_equal 100, block.call(50)
    end
  end

  specify 'it returns whatever the block returns' do
    returned = block_and_forth do
      123
    end
    assert_equal 123, returned
  end

  example 'more sophisticated :)' do
    returned = block_and_forth do |&block|
      results = []
      results << block.call(3)
      results << block.call(2)
      results << block.call(1)
      results
    end
    assert_equal [6, 4, 2], returned
  end
end
