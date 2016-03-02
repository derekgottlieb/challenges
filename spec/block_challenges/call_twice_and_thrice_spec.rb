require 'block_challenges/challenges'

RSpec.describe 'block challenges' do
  specify 'call_twice calls the block two times' do
    i = 0
    call_twice { i += 1 }
    assert_equal 2, i
  end

  specify 'call_thrice calls the block three times' do
    i = 0
    call_thrice { i += 1 }
    assert_equal 3, i
  end
end


