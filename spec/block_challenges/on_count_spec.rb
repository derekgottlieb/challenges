require 'block_challenges/challenges'

RSpec.describe 'OnCount' do
  it 'gets initialized with a count, which can be asked for later' do
    assert_equal 3, OnCount.new(3).count
    assert_equal 10, OnCount.new(10).count
  end

  it 'defaults the count to 0' do
    assert_equal 0, OnCount.new.count
  end

  it 'does not allow the outside world to modify the count' do
    assert_equal false, OnCount.new.respond_to?(:count=)
  end

  context 'turning it on and off (this will be used by the callback later)' do
    let(:oc) { OnCount.new }
    # HINT: There should only be one variable to track this
    it 'starts out in an on state' do
      assert_equal true,  oc.on?
      assert_equal false, oc.off?
    end

    it 'can be turned off and on' do
      assert_equal true,  oc.on?
      assert_equal true,  oc.on?
      assert_equal false, oc.off?
      assert_equal false, oc.off?

      oc.off
      assert_equal false, oc.on?
      assert_equal false, oc.on?
      assert_equal true,  oc.off?
      assert_equal true,  oc.off?

      oc.on
      assert_equal true,  oc.on?
      assert_equal true,  oc.on?
      assert_equal false, oc.off?
      assert_equal false, oc.off?

      oc.off
      assert_equal false, oc.on?
      assert_equal false, oc.on?
      assert_equal true,  oc.off?
      assert_equal true,  oc.off?
    end

    it 'can be turned on and off conveniently' do
      # note that we're calling off? on whatever gets returned from oc.off,
      # so we must be expecting oc.off to return the object itself
      assert_equal true,  oc.off.off?
      assert_equal false, oc.on.off?
    end

    it 'can be turned on' do
      assert_equal false, oc.off.on.off?
      assert_equal true,  oc.on?
      assert_equal true,  oc.on.on.on.on.on?
      assert_equal false, oc.off?
    end
  end

  describe 'count!' do
    context 'when turned on' do
      it 'increments the count' do
        oc = OnCount.new 100
        assert_equal 100, oc.count
        oc.count!
        assert_equal 101, oc.count
        oc.count!
        assert_equal 102, oc.count
      end
      specify 'a block can be given to initialize, which will be called upon incrementing, this is called a "callback"' do
        seen = []
        oc   = OnCount.new { |n| seen << n }
        assert_equal [],     seen
        oc.count!
        assert_equal [1],    seen
        oc.count!
        assert_equal [1, 2], seen
      end
      it 'returns itself' do
        oc = OnCount.new
        assert_equal oc, oc.count!
      end
    end

    context 'when turned off' do
      it 'increments the count' do
        oc = OnCount.new.off
        assert_equal 0, oc.count
        oc.count!
        assert_equal 1, oc.count
        oc.count!
        assert_equal 2, oc.count
      end
      it 'does not call the callback when turned off' do
        seen = []
        oc   = OnCount.new { |n| seen << n }.off
        assert_equal [], seen
        assert_equal oc, oc.count!
      end
      it 'returns itself' do
        seen = []
        oc   = OnCount.new { |n| seen << n }.off
        assert_equal oc, oc.count!
      end
    end

    context 'when turned off and then back on' do
      it 'increments the count' do
        oc = OnCount.new(100).off.on
        assert_equal 100, oc.count
        oc.count!
        assert_equal 101, oc.count
        oc.count!
        assert_equal 102, oc.count
      end
      specify 'a block can be given to initialized, which will be called upon incrementing, this is called a "callback"' do
        seen = []
        oc   = OnCount.new { |n| seen << n }.off.on
        assert_equal [],     seen
        oc.count!
        assert_equal [1],    seen
        oc.count!
        assert_equal [1, 2], seen
      end
      it 'returns itself' do
        oc = OnCount.new.off.on
        assert_equal oc, oc.count!
      end
    end
  end
end
