require 'linked_list_functions/challenges'

RSpec.describe 'linked list functions' do
  describe 'list_size' do
    it 'is 0 for an empty list' do
      list = LinkedList.new
      assert_equal 0, list_size(list)
    end

    it 'is 1 for a list with one item' do
      list = LinkedList.new(Node.new("a", nil))
      assert_equal 1, list_size(list)
    end

    it 'is 2 for a list with two items' do
      list = LinkedList.new(Node.new("a", Node.new("b", nil)))
      assert_equal 2, list_size(list)
    end

    it 'is 3 for a list with three items' do
      list = LinkedList.new(Node.new("a", Node.new("b", Node.new("c", nil))))
      assert_equal 3, list_size(list)
    end

    it 'does not care what is in the list' do
      list = LinkedList.new(Node.new("c", Node.new("b", Node.new("a", nil))))
      assert_equal 3, list_size(list)
    end
  end
end

