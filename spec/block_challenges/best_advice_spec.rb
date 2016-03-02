require 'block_challenges/challenges'

RSpec.describe 'block challenges' do
  describe 'best_advice returns the first element from an array where the block returns true' do
    example '[1,5,2] which is odd?' do
      advice = best_advice([1,5,2]) { |n| n.odd? }
      assert_equal 1, advice
    end

    example '[1,5,2] which is a multiple of 5' do
      advice = best_advice([1,5,2]) { |n| n % 5 == 0 }
      assert_equal 5, advice
    end

    example '[1,5,2] which is even?' do
      advice = best_advice([1,5,2]) { |n| n.even? }
      assert_equal 2, advice
    end

    example '[1,5,2] which is 8?' do
      advice = best_advice([1,5,2]) { |n| n == 8 }
      assert_equal nil, advice
    end

    example '[1,5,2] i like everything!' do
      advice = best_advice([1,5,2]) { |n| true }
      assert_equal 1, advice
    end

    example '[1,5,2] i hate everything!' do
      advice = best_advice([1,5,2]) { |n| false }
      assert_equal nil, advice
    end
  end
end
