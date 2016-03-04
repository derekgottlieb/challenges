require 'block_challenges/challenges'

RSpec.describe 'block_and_forth_forever' do
  it 'receives a block, and calls it' do
    called = false
    block_and_forth_forever do
      called = true
    end
    assert_equal true, called
  end

  it 'calls it with a block' do
    block_and_forth_forever do |&block|
      assert_equal Proc, block.class
    end
  end

  specify 'the block it passes receives another block and calls it' do
    called = false
    block_and_forth_forever do |&block|
      block.call { called = true }
    end
    assert_equal called, true
  end

  specify 'it returns whatever the block returns' do
    returned = block_and_forth_forever do |&block|
      block.call { |&b| b.call { 123 } }
    end
    assert_equal 123, returned
  end

  it 'does this indefinitely deep' do
    returned = block_and_forth_forever do |&b0|
      b0.call { |&b1| b1.call { |&b2| b2.call { |&b3| b3.call { |&b4| b4.call { |&b5| b5.call { |&b6| b6.call { |&b7| b7.call { |&b8| b8.call { |&b9| b9.call { |&b10| b10.call { |&b11| b11.call { |&b12| b12.call { |&b13| b13.call { |&b14| b14.call { |&b15| b15.call { |&b16| b16.call { |&b17| b17.call { |&b18| b18.call { |&b19| b19.call { |&b20| b20.call { |&b21| b21.call { |&b22| b22.call { |&b23| b23.call { |&b24| b24.call { |&b25|
        b25.call { |&b26| b26.call { |&b27| b27.call { |&b28| b28.call { |&b29| b29.call { |&b30| b30.call { |&b31| b31.call { |&b32| b32.call { |&b33| b33.call { |&b34| b34.call { |&b35| b35.call { |&b36| b36.call { |&b37| b37.call { |&b38| b38.call { |&b39| b39.call { |&b40| b40.call { |&b41| b41.call { |&b42| b42.call { |&b43| b43.call { |&b44| b44.call { |&b45| b45.call { |&b46| b46.call { |&b47| b47.call { |&b48| b48.call { |&b49| b49.call { |&b50|
          b50.call { |&b51| b51.call { |&b52| b52.call { |&b53| b53.call { |&b54| b54.call { |&b55| b55.call { |&b56| b56.call { |&b57| b57.call { |&b58| b58.call { |&b59| b59.call { |&b60| b60.call { |&b61| b61.call { |&b62| b62.call { |&b63| b63.call { |&b64| b64.call { |&b65| b65.call { |&b66| b66.call { |&b67| b67.call { |&b68| b68.call { |&b69| b69.call { |&b70| b70.call { |&b71| b71.call { |&b72| b72.call { |&b73| b73.call { |&b74| b74.call { |&b75|
            b75.call { |&b76| b76.call { |&b77| b77.call { |&b78| b78.call { |&b79| b79.call { |&b80| b80.call { |&b81| b81.call { |&b82| b82.call { |&b83| b83.call { |&b84| b84.call { |&b85| b85.call { |&b86| b86.call { |&b87| b87.call { |&b88| b88.call { |&b89| b89.call { |&b90| b90.call { |&b91| b91.call { |&b92| b92.call { |&b93| b93.call { |&b94| b94.call { |&b95| b95.call { |&b96| b96.call { |&b97| b97.call { |&b98| b98.call { |&b99| b99.call {
              # stops here b/c I didn't call the block again
              called = true
              :a_local_variable_makes_this_one_easy
            }}}}}}}}}}}}}}}}}}}}}}}}}
          }}}}}}}}}}}}}}}}}}}}}}}}}
        }}}}}}}}}}}}}}}}}}}}}}}}}
      }}}}}}}}}}}}}}}}}}}}}}}}}
    end
    assert_equal :a_local_variable_makes_this_one_easy, returned
  end
end
