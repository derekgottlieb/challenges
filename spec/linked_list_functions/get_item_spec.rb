require 'linked_list_functions/challenges'

RSpec.describe 'linked list functions' do
  describe 'get_item' do
    it 'returns nil when asked for an item in an empty list' do
      list = LinkedList.new
      assert_equal nil, get_item(list, 0)
    end

    it 'returns nil when asked for an item well into an empty list' do
      list = LinkedList.new
      assert_equal nil, get_item(list, 5)
    end

    it 'returns nil when asked for an item past the end of a list with items in it' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal nil, get_item(list, 1)
    end

    it 'returns nil when asked for an item well past the end of a list with items in it' do
      list = LinkedList.new(Node.new("a", Node.new("b", nil)))
      assert_equal nil, get_item(list, 100)
    end

    it 'finds the first item when asked for index 0' do
      list = LinkedList.new(Node.new("a", Node.new("b", nil)))
      assert_equal 'a', get_item(list, 0)
    end

    it 'finds the first item when asked for index 1' do
      list = LinkedList.new(Node.new("a", Node.new("b", nil)))
      assert_equal 'b', get_item(list, 1)
    end

    it 'finds each item in a long list' do
      list = LinkedList.new(Node.new("c", Node.new("b", Node.new("a", nil))))
      assert_equal 'c', get_item(list, 0)
      assert_equal 'b', get_item(list, 1)
      assert_equal 'a', get_item(list, 2)
      assert_equal nil, get_item(list, 3)
    end
  end
end
