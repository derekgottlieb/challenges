require 'block_challenges/challenges'

RSpec.describe 'aside' do
  it 'can be called on an object' do
    'abc'.aside { }
    123.aside { }
  end

  it 'gives the block the object I called it on' do
    seen = nil
    'abc'.aside { |str| seen = str }
    assert_equal 'abc', seen
  end

  it 'returns the object I called it on' do
    returned = 'abc'.aside { 123 }
    assert_equal returned, 'abc'

    returned = :lol.aside { 123 }
    assert_equal :lol, returned
  end

  context 'when called without a block' do
    it 'raises a LocalJumpError, saying that no block was given' do
      raised = false
      begin
        "abc".aside
      rescue LocalJumpError => err
        raised = true
        assert_equal "no block given", err.message
      end
      assert_equal true, raised
    end
  end
end
