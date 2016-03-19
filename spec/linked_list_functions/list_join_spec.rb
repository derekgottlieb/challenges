require 'linked_list_functions/challenges'

RSpec.describe 'linked list functions' do
  describe 'list_join' do
    context 'when not given a delimiter' do
      it 'returns an empty string when given an empty list' do
        list = LinkedList.new
        assert_equal '', list_join(list)
      end
      it 'returns its head\'s to_s when it only has a head' do
        list = LinkedList.new(Node.new(123, nil))
        assert_equal '123', list_join(list)
      end
      it 'returns each of its items to_s, concatenated' do
        list = LinkedList.new(Node.new('abc', Node.new(123, Node.new(:lol, nil))))
        assert_equal 'abc123lol', list_join(list)
      end
    end

    context 'when given a delimiter' do
      it 'returns an empty string when given an empty list' do
        list = LinkedList.new
        assert_equal '', list_join(list, ", ")
      end
      it 'returns its head\'s to_s when it only has a head' do
        list = LinkedList.new(Node.new(123, nil))
        assert_equal '123', list_join(list, ", ")
      end
      it 'returns each of its items to_s, concatenated, with the delimiter concatenated between each' do
        list = LinkedList.new(Node.new('abc', Node.new(123, Node.new(:lol, nil))))
        assert_equal 'abc-123-lol',   list_join(list, "-")
        assert_equal 'abc, 123, lol', list_join(list, ", ")
        assert_equal 'abc...123...lol', list_join(list, "...")
      end
    end
  end
end
