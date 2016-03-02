require 'block_challenges/challenges'

RSpec.describe 'block challenges' do
  describe 'wrap' do
    it 'receives a value and returns a block' do
      assert_equal Proc, wrap(2).class
    end
    specify 'when you call the returned block, you get the value you passed in' do
      assert_equal 'a', wrap('a').call
    end
  end
end
